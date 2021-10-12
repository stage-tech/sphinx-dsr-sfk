import { CodeGenerator } from './lib/code-generator';
// import { RecipePlaceholder, RecipePlacefolder } from './recipes';

const envName = process.argv[2];
const runningFrom: string = process.cwd() + '/generated';

// new CodeGenerator().run(runningFrom, envName, [new RecipePlaceholder(envName), new RecipePlacefolder(envName)]);
