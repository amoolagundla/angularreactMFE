declare module 'systemjs' {
  const System: any;
  export = System;
}

declare var System: {
  import(url: string): Promise<any>;
};