<template>
  <span class="mr-4">
    <v-tooltip bottom>
      <template v-slot:activator="{ on, attrs }">
        <v-btn
          @click="resetFilter"
          color="orange"
          icon
          v-bind="attrs"
          v-on="on"
          :disabled="!isFiltering"
        >
          <v-icon color="white" dark> mdi-filter-off-outline </v-icon>
        </v-btn>
      </template>
      <span>Restar filtro</span>
    </v-tooltip>
  </span>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
export default {
  name: "ResetFilter",

  methods: {
    ...mapActions(["fetchProducts"]),
    resetFilter() {
      this.fetchProducts();
    },
  },
  computed: mapGetters(["allProducts", "isFiltering"]),
};
</script>