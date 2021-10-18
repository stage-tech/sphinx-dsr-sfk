import { Definition, Field, Type } from '../model';
import { IConverter } from './converter-interface';

export class DefaultConverter implements IConverter {
  converts: Type;
  buildConversionExpression(field: Field, def?: Definition): string {
    const fieldName = field.name.toUpperCase();
    return field.required
      ? `${fieldName}[0]::string`
      : `IFF(trim(${fieldName}[0]::string)='',NULL,${fieldName}[0]::string)`;
  }
}
