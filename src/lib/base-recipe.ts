import fs from 'fs';
import path from 'path';

import { IGenerator, IRecipe } from './interfaces';
import { Definition } from './model';

export abstract class BaseRecipe implements IRecipe {
  protected abstract getRecipe(): IGenerator[];

  generate(): { location: string; content: string; generatorName: string }[] {
    return this.getRecipe().map((g) => {
      const content = g.generate();
      const location = g.outputPath;
      return { content, location, generatorName: g.constructor.name };
    });
  }
}

export abstract class SchemaBaseRecipe extends BaseRecipe {
  constructor(private definitionFilePath: string) {
    super();
  }

  getDefinition(): Definition {
    const definitionFilePath = path.resolve(this.definitionFilePath);
    return JSON.parse(fs.readFileSync(definitionFilePath, 'utf-8'));
  }
}
