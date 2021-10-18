import { CodeGenerator } from './lib/code-generator';
import { AssetRecipe } from './recipes/asset/recipe';
import {
  AvpMrb10Recipe,
  BapMrb11Recipe,
  BapMrb12Recipe,
  BapMrb13Recipe,
  BapRecipe,
  DdexDsrDbRecipe,
} from './recipes/ddex-dsr/recipe';

const envName = process.argv[2];
const runningFrom: string = process.cwd() + '/generated';

new CodeGenerator().run(runningFrom, envName, [
  new AssetRecipe(envName),
  new DdexDsrDbRecipe(envName),
  new AvpMrb10Recipe(envName),
  new BapMrb11Recipe(envName),
  new BapMrb12Recipe(envName),
  new BapMrb13Recipe(envName),
  new BapRecipe(envName),
]);
