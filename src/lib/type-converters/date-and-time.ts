import { Field, Type } from '../model';
import { IConverter } from './converter-interface';
function multipleCast(fieldName: string, allowedValues: string[], required: boolean, func: string) {
  let validationString: string;
  if (allowedValues.length < 2) {
    validationString = `${func}(${fieldName}[0]::string, '${allowedValues[0]}')`;
  } else {
    validationString = `COALESCE(`;
    for (let i = 0; i < allowedValues.length; i++) {
      const allowedValue = allowedValues[i];
      const isLast = i == allowedValues.length - 1;
      validationString += `${func}(${fieldName}[0]::string, '${allowedValue}')`;
      if (!isLast) {
        validationString += ',';
      }
    }

    validationString += ')';
  }
  return validationString;
}
export class DateTimeConverter implements IConverter {
  converts = Type.DATETIME;
  buildConversionExpression(field: Field): string {
    const fieldName = field.name.toUpperCase();
    return multipleCast(fieldName, field.allowedValues, field.required, 'TRY_TO_TIMESTAMP');
  }
}

export class DateConverter implements IConverter {
  converts = Type.DATE;
  buildConversionExpression(field: Field): string {
    const fieldName = field.name.toUpperCase();
    return multipleCast(fieldName, field.allowedValues, field.required, 'TRY_TO_DATE');
  }
}

export class TimeConverter implements IConverter {
  converts = Type.TIME;
  buildConversionExpression(field: Field): string {
    const fieldName = field.name.toUpperCase();
    return multipleCast(fieldName, field.allowedValues, field.required, 'TRY_TO_TIME');
  }
}
