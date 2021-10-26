import { Field, Type } from '../../model';
import { IValidationStrategy } from './validation-strategy';

export class NumericInteger implements IValidationStrategy {
  getSqlValidationRule(field: Field, modelName: string): string | undefined {
    const fieldName = field.name.toUpperCase();
    let violationRule = '';
    if (field.type == Type.INTEGER) {
      violationRule += `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::string REGEXP '\\\\\\\\d+', null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'NOT_INTEGER')))\n`;
      if (field.minSize) {
        violationRule += `,${new NumericMinimum().getSqlValidationRule(field, modelName)}\n`;
      }
      if (field.maxSize) {
        violationRule += `,${new NumericMaximum().getSqlValidationRule(field, modelName)}\n`;
      }
      return violationRule;
    }

    return undefined;
  }
}

export class NumericDecimal implements IValidationStrategy {
  getSqlValidationRule(field: Field, modelName: string): string | undefined {
    const fieldName = field.name.toUpperCase();
    let violationRule = '';
    if (field.type == Type.DECIMAL) {
      violationRule += `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::string REGEXP '\\\\\\\\d+(\\\\.\\\\\\\\d+)?', null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'NOT_DECIMAL')))\n`;
      if (field.minSize) {
        violationRule += `,${new NumericMinimum().getSqlValidationRule(field, modelName)}\n`;
      }
      if (field.maxSize) {
        violationRule += `,${new NumericMaximum().getSqlValidationRule(field, modelName)}\n`;
      }
      return violationRule;
    }

    return undefined;
  }
}

export class NumericMinimum implements IValidationStrategy {
  getSqlValidationRule(field: Field, modelName: string): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.type == Type.INTEGER || field.type == Type.DECIMAL) {
      if (field.minSize)
        return `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::number >= ${field.minSize}, null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'LESS_THAN_MIN_SIZE')))`;
    }

    return undefined;
  }
}

export class NumericMaximum implements IValidationStrategy {
  getSqlValidationRule(field: Field, modelName: string): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.type == Type.INTEGER || field.type == Type.DECIMAL) {
      if (field.maxSize)
        return `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::number <= ${field.maxSize}, null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'GREATER_THAN_MAX_SIZE')))`;
    }

    return undefined;
  }
}
