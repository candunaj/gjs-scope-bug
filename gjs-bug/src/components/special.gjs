import hbs from 'htmlbars-inline-precompile';

const button = hbs`
  <button type='button'>Submit</button>
`;
const components = {
  button
};

<template>
  {{yield components}}
</template>
