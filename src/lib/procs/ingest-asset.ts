import { IGenerator } from '../interfaces';
import { ExecutionType, StoredProcedureWrapper } from './proc-wrapper';

export interface Props {
  fullIngestFileProc: string;
  fullIngestRecordProc: string;
  validationSchemaName: string;
  validationViewName: string;
  schemaName: string;
  publishAssetProc: string;
}
export class IngestAsset implements IGenerator {
  constructor(private props: Props) {}

  outputPath = 'procs/ingest-asset.sql';
  generate(): string {
    const procedureBody = `
    function createExpectedRecordsError(expectedRecords, loadedRecords) {
      var message = expectedRecords + ' ID records expected, ' + loadedRecords + ' found'
      var args = [{
        key: 'expectedRecords',
        value: String(expectedRecords)
      }, {
        key: 'loadedRecords',
        value: String(loadedRecords)
      }];

      createErrorState(messageTypes.ERROR_MESSAGE, message, args)
    }

    function createViolationsError(recordType, violations, records) {
      var message = violations + ' constraint violation(s) across, ' + records + ' ' + recordType + ' record(s)';
      var args = [{
        key: 'recordType',
        value: recordType
      }, {
        key: 'violations',
        value: String(violations)
      }, {
        key: 'records',
        value: String(records)
      }];

      createErrorState(messageTypes.ERROR_MESSAGE, message, args)
    }

    function createInvoiceDiscrepancyError(errorPct) {
      var message = errorPct.toFixed(2) + '% discrepancy on invoiced total (allowed 0.1%)'
      var args = [{
        key: 'errorPct',
        value: String(errorPct)
      }];

      createErrorState(messageTypes.ERROR_MESSAGE, message, args)
    }

    var ingestFileStatement = snowflake.createStatement({sqlText: \`CALL  ${this.props.fullIngestFileProc}(:1 , :2); \`,binds: [ASSET_ID , REFERENCE_COPY_ID]});
    ingestFileStatement.execute();
    var ingestRecordsStatement = snowflake.createStatement({sqlText: \`CALL  ${this.props.fullIngestRecordProc}(:1); \`,binds: [ASSET_ID]});
    var result = ingestRecordsStatement.execute();

    var validateQueryStatement = snowflake.createStatement({
      sqlText: \`SELECT * FROM ${this.props.validationSchemaName}.${this.props.validationViewName} WHERE ASSET_ID = :1;\`,
      binds: [ASSET_ID]
    });
    var validateQueryResult = validateQueryStatement.execute();


    if (!validateQueryResult.getRowCount()) {
      createErrorState(messageTypes.ERROR_MESSAGE, 'Asset not found in validation checksum view', { key: 'assetId', value: ASSET_ID })
    } else {
      validateQueryResult.next();
      if (validateQueryResult.LOADED_ID_RECORDS !== validateQueryResult.EXPECTED_ID_RECORDS) {
        createExpectedRecordsError(validateQueryResult.EXPECTED_ID_RECORDS, validateQueryResult.LOADED_ID_RECORDS)
      }
      if (validateQueryResult.VIOLATIONS_ID.records > 0) {
        createViolationsError('ID',validateQueryResult.VIOLATIONS_ID.violations, validateQueryResult.VIOLATIONS_ID.records)
      }
      if (validateQueryResult.VIOLATIONS_HD.records > 0) {
        createViolationsError('HD',validateQueryResult.VIOLATIONS_HD.violations, validateQueryResult.VIOLATIONS_HD.records)
      }
      if (validateQueryResult.VIOLATIONS_TR.records > 0) {
        createViolationsError('TR',validateQueryResult.VIOLATIONS_TR.violations, validateQueryResult.VIOLATIONS_TR.records)
      }
      if (validateQueryResult.ERROR_PCT > 0.1 || validateQueryResult.ERROR_PCT < -0.1) {
        createInvoiceDiscrepancyError(validateQueryResult.ERROR_PCT)
      }
    }

   if (executionResult.state !== states.ERROR) {
      var publishAssetStatement = snowflake.createStatement({sqlText: \`CALL  ${this.props.publishAssetProc}(:1); \`,binds: [ASSET_ID]});
      publishAssetStatement.execute();
    }

`;

    const storedProcSql = new StoredProcedureWrapper().wrap({
      executionType: ExecutionType.ERROR_TRAPPED,
      Name: `${this.props.schemaName}.INGEST_ASSET`,
      body: procedureBody,
      returnType: 'varchar',
      parameters: [
        {
          name: 'ASSET_ID',
          type: 'varchar',
        },
        {
          name: 'REFERENCE_COPY_ID',
          type: 'varchar',
        },
        {
          name: 'PROCESS_ID',
          type: 'varchar',
        },
      ],
    });

    return storedProcSql;
  }
}
