<template>
  <v-text-field
    v-model="productName"
    label="Nome do produto"
    prepend-icon="mdi-archive-search"
    value=""
    :rules="inputRules"
    @keypress="filter"
  />
</template>

<script>
import { mapActions, mapMutations } from "vuex";
export default {
  name: "FilterInput",
  data() {
    return {
      productName: "",
      produto: "teste",
      inputRules: [(v) => v != typeof "" || "Produto Inválido"],
    };
  },
  methods: {
    ...mapActions(["filterAction"]),
    filter() {
      // call action
      this.filterAction(this.productName);

      /*  // call mutation directly
      this.$store.commit(); */
    },
  },
};
</script>