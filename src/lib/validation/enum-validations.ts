import { IGenerator } from '../interfaces';
import { Definition, Type } from '../model';
import { Naming } from '../utility/naming';
import { EnumValidationUtils } from './enum-validation-utils';

export class EnumValidations implements IGenerator {
  constructor(private def: Definition) {}

  outputPath = 'validation/enum_udf.sql';
  generate(): string {
    const def = this.def;
    const schemaName = Naming.validationSchemaName(def);
    let sqlBuffer = '';
    if (def.enums) {
      Object.keys(def.enums).map((enumName) => {
        sqlBuffer += '\n' + EnumValidationUtils.isEnumFunctionDdl(schemaName, enumName, def.enums[enumName].values);
      });
    }
    return sqlBuffer;
  }
}
