import { UntypedDeleteSp } from '@/lib/untyped/delete-sp';
import { Naming } from '@/lib/utility/naming';
import { ValidationInsertSp } from '@/lib/validation/validation-insert-sp';
import { ValidationView } from '@/lib/validation/validation-view';

import { StaticTemplateGenerator } from '../../lib';
import { BaseRecipe, SchemaBaseRecipe } from '../../lib/base-recipe';
import { IGenerator } from '../../lib/interfaces';
import { TypedViews } from '../../lib/typed/typed-views';
import { UntypedInsertSp } from '../../lib/untyped/insert-sp';
import { UntypedRecordTables } from '../../lib/untyped/untyped-record-tables';

export class DdexDsrDbRecipe extends BaseRecipe {
  commonSubstitutions: { [key: string]: string };
  constructor(envName: string) {
    super();
    this.commonSubstitutions = {
      ENV: envName.toUpperCase(),
    };
  }

  getRecipe(): IGenerator[] {
    const templateBase = 'src/recipes/ddex-dsr';
    return [
      new StaticTemplateGenerator(`${templateBase}/database.sql`, '/database.sql', this.commonSubstitutions),
      new StaticTemplateGenerator(
        `${templateBase}/ingest-asset-sp.sql`,
        '/ingest-asset-sp.sql',
        this.commonSubstitutions,
      ),
      new StaticTemplateGenerator(
        `${templateBase}/insert-ingest-config.sql`,
        '/insert-ingest-config.sql',
        this.commonSubstitutions,
      ),
    ];
  }
}

export class AvpMrb10Recipe extends SchemaBaseRecipe {
  commonSubstitutions: { [key: string]: string };
  templateBase = 'src/recipes/ddex-dsr/avp/mrb-10';
  def = this.getDefinition();
  constructor(envName: string) {
    super('definitions/ddex-dsr/avp-mrb-v1.0.json');
    this.commonSubstitutions = {
      ENV: envName.toUpperCase(),
    };
  }

  getRecipe(): IGenerator[] {
    return buildDdexStaticTemplates(this.templateBase, this.commonSubstitutions, this.def);
  }
}

export class BapMrb11Recipe extends SchemaBaseRecipe {
  commonSubstitutions: { [key: string]: string };
  templateBase = 'src/recipes/ddex-dsr/bap/mrb-11';
  def = this.getDefinition();
  constructor(envName: string) {
    super('definitions/ddex-dsr/bap-mrb-v1.1.json');
    this.commonSubstitutions = {
      ENV: envName.toUpperCase(),
    };
  }
  getRecipe(): IGenerator[] {
    return buildDdexStaticTemplates(this.templateBase, this.commonSubstitutions, this.def);
  }
}

export class BapMrb12Recipe extends SchemaBaseRecipe {
  commonSubstitutions: { [key: string]: string };
  templateBase = 'src/recipes/ddex-dsr/bap/mrb-12';
  def = this.getDefinition();
  constructor(envName: string) {
    super('definitions/ddex-dsr/bap-mrb-v1.2.json');
    this.commonSubstitutions = {
      ENV: envName.toUpperCase(),
    };
  }
  getRecipe(): IGenerator[] {
    return buildDdexStaticTemplates(this.templateBase, this.commonSubstitutions, this.def);
  }
}

export class BapMrb13Recipe extends SchemaBaseRecipe {
  commonSubstitutions: { [key: string]: string };
  templateBase = 'src/recipes/ddex-dsr/bap/mrb-13';
  def = this.getDefinition();
  constructor(envName: string) {
    super('definitions/ddex-dsr/bap-mrb-v1.3.json');
    this.commonSubstitutions = {
      ENV: envName.toUpperCase(),
    };
  }
  getRecipe(): IGenerator[] {
    return buildDdexStaticTemplates(this.templateBase, this.commonSubstitutions, this.def);
  }
}

export class BapRecipe extends BaseRecipe {
  commonSubstitutions: { [key: string]: string };
  templateBase = 'src/recipes/ddex-dsr/bap';
  constructor(envName: string) {
    super();
    this.commonSubstitutions = {
      ENV: envName.toUpperCase(),
    };
  }
  getRecipe(): IGenerator[] {
    return [new StaticTemplateGenerator(`${this.templateBase}/bap.sql`, '/bap.sql', this.commonSubstitutions)];
  }
}

export const buildDdexStaticTemplates = (
  templateBase: string,
  commonSubstitutions: { [key: string]: string },
  def?: any,
) => {
  const untypedSchema = Naming.untypedSchemaName(def);
  const typedSchema = Naming.typedSchemaName(def);
  return [
    new StaticTemplateGenerator(`${templateBase}/schema.sql`, '/schema.sql', commonSubstitutions),
    new UntypedRecordTables({
      def,
      schemaName: untypedSchema,
    }),
    new UntypedDeleteSp(def, `${commonSubstitutions.ENV}_DDEX_DSR`),
    new UntypedInsertSp(def, `${commonSubstitutions.ENV}_DDEX_DSR`),
    new TypedViews({
      def,
      schemaName: typedSchema,
      sourceSchemaName: untypedSchema,
    }),
    new ValidationView(def, `${commonSubstitutions.ENV}_DDEX_DSR`),
    new StaticTemplateGenerator(
      `${templateBase}/validation/structure-view.sql`,
      '/validation/structure-view.sql',
      commonSubstitutions,
    ),
    new StaticTemplateGenerator(`${templateBase}/validation/model.sql`, '/validation/model.sql', commonSubstitutions),
    new ValidationInsertSp(def, `${commonSubstitutions.ENV}_DDEX_DSR`),
    new StaticTemplateGenerator(
      `${templateBase}/validation/delete-sp.sql`,
      '/validation/delete-sp.sql',
      commonSubstitutions,
    ),
  ];
};
