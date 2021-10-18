import { BaseRecipe, StaticTemplateGenerator } from '../../lib';
import { IGenerator } from '../../lib/interfaces';

export class RawRecipe extends BaseRecipe {
  commonSubstitutions: { [key: string]: string };
  constructor(envName: string) {
    super();
    this.commonSubstitutions = {
      ENV: envName.toUpperCase(),
    };
  }

  getRecipe(): IGenerator[] {
    const templateBase = 'src/recipes/raw';
    return [
      new StaticTemplateGenerator(`${templateBase}/integration.sql`, '/integration.sql', this.commonSubstitutions),
    ];
  }
}
