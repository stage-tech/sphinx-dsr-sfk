import { Field, Type } from '../model';
import { IConverter } from './converter-interface';

export class ArrayConverter implements IConverter {
  converts = Type.ARRAY;
  buildConversionExpression(field: Field): string {
    const fieldName = field.name.toUpperCase();
    return fieldName;
  }
}
