When a component yields hash with components, as in the following example:

```hbs
<!-- special.gjs -->
const components = { button: hbs`<button>...</button>`};
{{yield components}}
```

```hbs
<!-- my-button.gjs -->
import Special from './special';
<template>
  <Special as |b|>
    <b.button />
  </Special>
</template>
```

then rollup plugin `glimmerTemplateTag` generates 'b' in the scope. 'b' is undefined in the generated javascript file as you can see below:

```js
// my-button.js
import templateOnly from '@ember/component/template-only';
import { setComponentTemplate } from '@ember/component';
import { precompileTemplate } from '@ember/template-compilation';
import Special from './special.js';

var myButton = setComponentTemplate(
  precompileTemplate(
    `
  <Special as |b|>
    <b.button />
  </Special>
`,
    {
      strictMode: true,
      scope: () => ({
        Special,
        b,
      }),
    }
  ),
  templateOnly('my-button', '_myButton')
);

export { myButton as default };
```

## Expected result

'b' shouldn't be in the scope.

```js
{
  ...,
  scope: () => ({
    Special,
  })
}
```
