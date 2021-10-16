<template>
  <div class="OLa">
    <FilterMenu />
    <!-- <section v-if="errored">
      <p>Erro ao carregar os produtos, aperte f5 ou volte mais tarde</p>
    </section>

    <span v-if="loading">Carregando...</span> -->
    <v-container>
      <v-row>
        <v-col
          cols="12"
          md="6"
          lg="4"
          v-for="product in allProducts"
          :key="product[0]"
        >
          <v-card class="mx-auto" max-width="344">
            <v-card-text>
              <div class="d-flex justify-space-between">
                <span
                  class="
                    text-h5 text--primary text-capitalize
                    font-weight-medium
                    mb-2
                  "
                >
                  {{ product[1] }}
                </span>
                <v-chip v-if="product[5] === 1" color="white" text-color="red">
                  {{ product[2] }} qtd
                  <v-icon right> mdi-alert</v-icon>
                </v-chip>
                <v-chip
                  v-else
                  class="ml-2"
                  color="white"
                  text-color="success"
                  small
                >
                  <v-icon right> mdi-checkbox-multiple-marked-outline</v-icon>
                </v-chip>
              </div>

              <span> Estoque:{{ product[2] }}</span>
              <div class="text--primary">R$: {{ product[3] }}</div>
            </v-card-text>
            <v-card-actions>
              <EditProductModal :product="product" />

              <DeleteDialog :product="product" />
            </v-card-actions>
          </v-card>
        </v-col>
      </v-row>

      <AddProductForm />
    </v-container>
  </div>
</template>


<script>
import { mapGetters, mapActions } from "vuex";

import AddProductForm from "../components/AddProductForm.vue";
import EditProductModal from "../components/EditProductModal.vue";
import DeleteDialog from "../components/DeleteDialog.vue";
import FilterMenu from "../components/filterComponents/FilterMenu.vue";

export default {
  name: "Product",
  data() {
    return {
      /*  loading: false,
      errored: false, */
    };
  },
  components: {
    AddProductForm,
    EditProductModal,
    DeleteDialog,
    FilterMenu,
  },
  methods: {
    ...mapActions(["fetchProducts"]),
  },
  computed: {
    ...mapGetters(["allProducts"]),
  },
  created() {
    this.fetchProducts();
  },
};
</script>
