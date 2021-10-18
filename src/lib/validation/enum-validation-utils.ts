export class EnumValidationUtils {
  static isEnumFunctionDdl(schemaName: string, enumName: string, enumValues: any[]) {
    const enumSql = `CREATE OR REPLACE FUNCTION ${schemaName}.is_${enumName}(value varchar)
          returns boolean
          as
          $$
            value in (
              '${enumValues.join("','")}'
            )
          $$
          ;`;
    return enumSql;
  }
}
