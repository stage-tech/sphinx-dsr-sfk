export const replaceAll = (str: string, find: string, replace: string) => {
  /* eslint-disable-next-line */
  const escapedFind = find.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, '\\$1');
  return str.replace(new RegExp(escapedFind, 'g'), replace);
};
