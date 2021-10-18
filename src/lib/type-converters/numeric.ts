import { Field, Type } from '../model';
import { IConverter } from './converter-interface';

export class NumericInteger implements IConverter {
  converts = Type.INTEGER;
  buildConversionExpression(field: Field): string {
    const fieldName = field.name.toUpperCase();
    return `try_to_number(${fieldName}[0]::string)`;
  }
}

export class NumericDecimal implements IConverter {
  converts = Type.DECIMAL;
  buildConversionExpression(field: Field): string {
    const fieldName = field.name.toUpperCase();
    const precision = (field?.typeOpt ?? {})['precision'] ?? 38;
    const scale = (field?.typeOpt ?? {})['scale'] ?? 6;
    return `try_to_number(${fieldName}[0]::string, ${precision}, ${scale})`;
  }
}
