<template>
  <v-dialog persistent transition="dialog-top-transition" max-width="80%">
    <!-- cart icon in menu bar -->
    <template v-slot:activator="{ on, attrs }">
      <v-btn text v-bind="attrs" v-on="on" color="orange">
        <span>({{ productsInCart.length }})</span>
        <v-icon>mdi-cart</v-icon>
      </v-btn>
    </template>

    <!-- Modal -->
    <template v-slot:default="dialog">
      <v-toolbar color="orange" class="white--text font-weight-medium"
        >Carrinho de vendas</v-toolbar
      >

      <v-card class="mb-1">
        <v-card-text class="py-4">
          <v-row align-content="center" justify="center">
            <v-col
              align-self="center"
              cols="10"
              v-for="product in productsInCart"
              :key="product[0]"
            >
              <div class="d-flex justify-space-between">
                <p class="text-h5 text--primary mb-0">{{ product[1] }}</p>

                <!-- WARNING replace . por , -->
                <span>
                  <strong class="text--primary"
                    >R$:{{ product[6] * product[3] }}</strong
                  >
                </span>
              </div>
              <span class="mr-8">Quantidade: {{ product[6] }}</span>

              <!-- Remove from cart -->
              <v-btn icon color="orange" @click="removeFromCart(product)">
                <v-icon>mdi-sticker-remove</v-icon>
              </v-btn>

              <v-divider></v-divider>
            </v-col>
          </v-row>
        </v-card-text>

        <!-- Buttons  -->
        <v-card-actions
          class="d-flex justify-space-between lonelyClass align-center"
        >
          <span>Total R$: {{ total }}</span>

          <div>
            <v-btn text @click="dialog.value = false">Close</v-btn>
            <v-btn
              :disabled="productsInCart.length === 0"
              text
              @click="makeSale((dialog.value = false))"
              >Vender</v-btn
            >
          </div>
        </v-card-actions>
      </v-card>
    </template>
  </v-dialog>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
export default {
  name: "Cart",
  data() {
    return {
      total: 0.0,
    };
  },
  methods: {
    ...mapActions(["sale", "removeFromCart"]),
    makeSale() {
      this.sale();
    },
  },
  computed: {
    ...mapGetters(["productsInCart"]),
  },
};
</script>

<style scoped>
.scroll {
  overflow: scroll;
}

.lonelyClass {
  width: 100%;
}
</style>