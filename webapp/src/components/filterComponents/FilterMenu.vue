<template>
  <v-menu offset-y>
    <template v-slot:activator="{ on, attrs }">
      <v-container>
        <v-row justify="start">
          <v-col cols="12" md="9" lg="10">
            <FilterInput />
          </v-col>

          <v-col cols="12" md="3" lg="2" align-self="center">
            <v-btn color="orange" dark v-bind="attrs" v-on="on">
              <span>Filter</span>
              <v-icon right>mdi-menu-down-outline</v-icon>
            </v-btn>
            <ResetFilter />
          </v-col>
        </v-row>
      </v-container>
    </template>

    <v-list>
      <!-- <v-list-item v-for="category in allCategories" :key="category[0]">
        <v-list-item-title
          class="text-capitalize"
          @click="filterByCategory(category)"
          >{{ category[1] }}</v-list-item-title
        >
      </v-list-item> -->
    </v-list>
  </v-menu>
</template>


<script>
import { mapActions, mapGetters } from "vuex";
import ResetFilter from "./ResetFilter.vue";
import FilterInput from "./FilterInput.vue";

export default {
  name: "FilterMenu",
  components: {
    ResetFilter,
    FilterInput,
  },
  /* methods: {
    ...mapActions(["fetchCategories", "filteredProducts"]),
    filterByCategory(category) {
      this.filteredProducts(category);
    },
  },
  computed: mapGetters(["allCategories"]),
  created() {
    this.fetchCategories();
  }, */
};
</script>