import { Field, Type } from '../model';
import { IConverter } from './converter-interface';

export class BooleanConverter implements IConverter {
  converts = Type.BOOLEAN;
  buildConversionExpression(field: Field): string {
    const fieldName = field.name.toUpperCase();
    return `try_to_boolean(${fieldName}[0]::string)`;
  }
}
