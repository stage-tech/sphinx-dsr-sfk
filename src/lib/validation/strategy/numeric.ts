import { Field, Type } from '../../model';
import { IValidationStrategy } from './validation-strategy';

export class NumericInteger implements IValidationStrategy {
  getSqlValidationRule(field: Field): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.type == Type.INTEGER) {
      return `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::string REGEXP '\\\\d+', null, '${fieldName}_NOT_INTEGER'))`;
    }

    return undefined;
  }
}

export class NumericDecimal implements IValidationStrategy {
  getSqlValidationRule(field: Field): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.type == Type.DECIMAL) {
      return `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::string REGEXP '-?\\\\d+(\\.\\\\d+)?', null, '${fieldName}_NOT_DECIMAL'))`;
    }

    return undefined;
  }
}

export class NumericMinimum implements IValidationStrategy {
  getSqlValidationRule(field: Field): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.type == Type.INTEGER || field.type == Type.DECIMAL) {
      if (field.minSize)
        return `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::number >= ${field.minSize}, null, '${fieldName}_LESS_THAN_MIN_SIZE'))`;
    }

    return undefined;
  }
}

export class NumericMaximum implements IValidationStrategy {
  getSqlValidationRule(field: Field): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.type == Type.INTEGER || field.type == Type.DECIMAL) {
      if (field.maxSize)
        return `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::number <= ${field.maxSize}, null, '${fieldName}_GREATER_THAN_MAX_SIZE'))`;
    }

    return undefined;
  }
}
