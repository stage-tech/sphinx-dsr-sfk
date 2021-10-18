import { Field } from '../model';
import { Converters } from './converters';
import { DefaultConverter } from './default-converter';

export class TypeConverter {
  static getConversionExpression(field: Field): string {
    const matchingConverter = Converters.find((c) => c.converts == field.type) ?? new DefaultConverter();
    return matchingConverter.buildConversionExpression(field);
  }
}
