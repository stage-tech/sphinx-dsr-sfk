import { Field, Type } from '../../model';
import { IValidationStrategy } from './validation-strategy';

export class ArrayMustBeExplicit implements IValidationStrategy {
  getSqlValidationRule(field: Field): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.type != Type.ARRAY) {
      return `IFF(${fieldName} is null OR ARRAY_SIZE(${fieldName}) <= 1, null, '${fieldName}_HAS_MULTIPLE_ITEMS')`;
    }

    return undefined;
  }
}

export class ArrayMinimumSizeValidation implements IValidationStrategy {
  getSqlValidationRule(field: Field): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.type == Type.ARRAY) {
      if (field.minSize) {
        `IFF(${fieldName} is null, null, IFF(ARRAY_SIZE(${fieldName}) >= ${field.minSize}, null, '${fieldName}_LESS_THAN_MIN_SIZE'))`;
      }
    }

    return undefined;
  }
}

export class ArrayMaximumSizeValidation implements IValidationStrategy {
  getSqlValidationRule(field: Field): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.type == Type.ARRAY) {
      if (field.maxSize) {
        `IFF(${fieldName} is null, null, IFF(ARRAY_SIZE(${fieldName}) <= ${field.maxSize}, null, '${fieldName}_GREATER_THAN_MAX_SIZE'))`;
      }
    }

    return undefined;
  }
}
