<template>
  <v-text-field
    label="Nome do produto"
    prepend-icon="mdi-archive-search"
    value=""
    :rules="inputRules"
  ></v-text-field>
</template>

<script>
export default {
  name: "FilterInput",
  data() {
    return {
      produto: "teste",
      inputRules: [(v) => v != typeof "" || "Produto Inválido"],
    };
  },
};
</script>