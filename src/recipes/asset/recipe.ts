import { BaseRecipe, StaticTemplateGenerator } from '../../lib';
import { IGenerator } from '../../lib/interfaces';

export class AssetRecipe extends BaseRecipe {
  commonSubstitutions: { [key: string]: string };
  constructor(envName: string) {
    super();
    this.commonSubstitutions = {
      ENV: envName.toUpperCase(),
    };
  }

  getRecipe(): IGenerator[] {
    const templateBase = 'src/recipes/asset';
    return [new StaticTemplateGenerator(`${templateBase}/database.sql`, '/database.sql', this.commonSubstitutions)];
  }
}
