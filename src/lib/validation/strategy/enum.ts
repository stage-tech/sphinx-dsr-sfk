import { Definition, Field, Type } from '../../model';
import { Naming } from '../../utility/naming';
import { IValidationStrategy } from './validation-strategy';

export class EnumValidation implements IValidationStrategy {
  getSqlValidationRule(field: Field, def: Definition): string | undefined {
    const schemaName = Naming.validationSchemaName(def);

    const fieldName = field.name.toUpperCase();
    if (field.type == Type.ENUM) {
      return `IFF(${fieldName}[0] is null, null, IFF(${schemaName}.is_${field?.typeRef}(${fieldName}[0]::string), null, '${fieldName}_NOT_ALLOWED_VALUE'))`;
    }

    return undefined;
  }
}
