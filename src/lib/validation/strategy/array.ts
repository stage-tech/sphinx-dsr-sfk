import { Field, Type } from '../../model';
import { IValidationStrategy } from './validation-strategy';

export class ArrayMustBeExplicit implements IValidationStrategy {
  getSqlValidationRule(field: Field, modelName: string): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.type != Type.ARRAY) {
      return `IFF(${fieldName} is null OR ARRAY_SIZE(${fieldName}) <= 1, null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'HAS_MULTIPLE_ITEMS'))`;
    }

    return undefined;
  }
}

export class ArrayMinimumSizeValidation implements IValidationStrategy {
  getSqlValidationRule(field: Field, modelName: string): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.type == Type.ARRAY) {
      if (field.minSize) {
        `IFF(${fieldName} is null, null, IFF(ARRAY_SIZE(${fieldName}) >= ${field.minSize}, null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'LESS_THAN_MIN_SIZE')))`;
      }
    }

    return undefined;
  }
}

export class ArrayMaximumSizeValidation implements IValidationStrategy {
  getSqlValidationRule(field: Field, modelName: string): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.type == Type.ARRAY) {
      if (field.maxSize) {
        `IFF(${fieldName} is null, null, IFF(ARRAY_SIZE(${fieldName}) <= ${field.maxSize}, null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'GREATER_THAN_MAX_SIZE')))`;
      }
    }

    return undefined;
  }
}
