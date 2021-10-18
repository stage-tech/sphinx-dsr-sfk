import { StaticTemplateGenerator } from '../../lib';
import { BaseRecipe } from '../../lib/base-recipe';
import { IGenerator } from '../../lib/interfaces';

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

export class AvpMrb10Recipe extends BaseRecipe {
  commonSubstitutions: { [key: string]: string };
  templateBase = 'src/recipes/ddex-dsr/avp/mrb-10';
  constructor(envName: string) {
    super();
    this.commonSubstitutions = {
      ENV: envName.toUpperCase(),
    };
  }
  getRecipe(): IGenerator[] {
    return buildDdexStaticTemplates(this.templateBase, this.commonSubstitutions);
  }
}

export class BapMrb11Recipe extends BaseRecipe {
  commonSubstitutions: { [key: string]: string };
  templateBase = 'src/recipes/ddex-dsr/bap/mrb-11';
  constructor(envName: string) {
    super();
    this.commonSubstitutions = {
      ENV: envName.toUpperCase(),
    };
  }
  getRecipe(): IGenerator[] {
    return buildDdexStaticTemplates(this.templateBase, this.commonSubstitutions);
  }
}

export class BapMrb12Recipe extends BaseRecipe {
  commonSubstitutions: { [key: string]: string };
  templateBase = 'src/recipes/ddex-dsr/bap/mrb-12';
  constructor(envName: string) {
    super();
    this.commonSubstitutions = {
      ENV: envName.toUpperCase(),
    };
  }
  getRecipe(): IGenerator[] {
    return buildDdexStaticTemplates(this.templateBase, this.commonSubstitutions);
  }
}

export class BapMrb13Recipe extends BaseRecipe {
  commonSubstitutions: { [key: string]: string };
  templateBase = 'src/recipes/ddex-dsr/bap/mrb-13';
  constructor(envName: string) {
    super();
    this.commonSubstitutions = {
      ENV: envName.toUpperCase(),
    };
  }
  getRecipe(): IGenerator[] {
    return buildDdexStaticTemplates(this.templateBase, this.commonSubstitutions);
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
): StaticTemplateGenerator[] => {
  return [
    new StaticTemplateGenerator(`${templateBase}/schema.sql`, '/schema.sql', commonSubstitutions),
    new StaticTemplateGenerator(`${templateBase}/untyped/model.sql`, '/untyped/model.sql', commonSubstitutions),
    new StaticTemplateGenerator(`${templateBase}/untyped/delete-sp.sql`, '/untyped/delete-sp.sql', commonSubstitutions),
    new StaticTemplateGenerator(`${templateBase}/untyped/insert-sp.sql`, '/untyped/insert-sp.sql', commonSubstitutions),
    new StaticTemplateGenerator(`${templateBase}/typed/view.sql`, '/typed/view.sql', commonSubstitutions),
    new StaticTemplateGenerator(`${templateBase}/validation/view.sql`, '/validation/view.sql', commonSubstitutions),
    new StaticTemplateGenerator(
      `${templateBase}/validation/structure-view.sql`,
      '/validation/structure-view.sql',
      commonSubstitutions,
    ),
    new StaticTemplateGenerator(`${templateBase}/validation/model.sql`, '/validation/model.sql', commonSubstitutions),
    new StaticTemplateGenerator(
      `${templateBase}/validation/insert-sp.sql`,
      '/validation/insert-sp.sql',
      commonSubstitutions,
    ),
    new StaticTemplateGenerator(
      `${templateBase}/validation/delete-sp.sql`,
      '/validation/delete-sp.sql',
      commonSubstitutions,
    ),
  ];
};
