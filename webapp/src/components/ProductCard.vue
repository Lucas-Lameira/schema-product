<template>
  <v-container>
    <v-row>
      <v-col
        cols="12"
        v-for="(saleProduct, index) in allProductsForSale"
        :key="index"
      >
        <v-card class="mx-auto mb-2" v-if="saleProduct[2] !== 0">
          <v-card-text>
            <div class="d-flex justify-space-between">
              <p class="text-h5 text--primary">
                {{ saleProduct[1] }}
              </p>
              <!-- WARNING replace . por , -->
              <span
                ><strong class="text--primary"
                  >R$: {{ saleProduct[3] }}</strong
                ></span
              >
            </div>

            <section class="d-flex justify-space-between">
              <div>
                <span class="mr-8">Estoque: {{ saleProduct[2] }}</span>

                <!-- dropdown menu -->
                <v-menu offset-y>
                  <template v-slot:activator="{ on, attrs }">
                    <v-btn
                      small
                      class="orange white--text"
                      :disabled="saleProduct[2] == 0"
                      v-bind="attrs"
                      v-on="on"
                    >
                      <span>Qtd: {{ saleProduct[6] }}</span>
                      <v-icon right>mdi-menu-down-outline</v-icon>
                    </v-btn>
                  </template>

                  <v-list>
                    <v-list-item
                      v-for="(quantity, index) in saleProduct[2]"
                      :key="index"
                      @click="updatePro(quantity, saleProduct[0])"
                    >
                      <v-list-item-title>{{ quantity }}</v-list-item-title>
                    </v-list-item>
                  </v-list>
                </v-menu>
              </div>
              <v-btn
                text
                color="orange"
                :disabled="saleProduct[6] === 0 || saleProduct[2] === 0"
                @click="addToCart(saleProduct)"
                class="px-0"
              >
                <span>adicionar ao carrinho {{ saleProduct[6] }}</span>
              </v-btn>
            </section>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>


<script>
import { mapActions, mapGetters } from "vuex";
export default {
  name: "ProductCard",
  methods: {
    ...mapActions([
      "fetchProductsForSale",
      "addToCart",
      "updateProductQauntity",
    ]),
    updatePro(quantity, id_product) {
      this.updateProductQauntity({ quantity, id_product });
    },
  },
  computed: {
    ...mapGetters(["allProductsForSale"]),
  },
  created() {
    this.fetchProductsForSale();
  },
};
</script>