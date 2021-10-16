<template>
  <v-dialog persistent transition="dialog-top-transition" max-width="80%">
    <template v-slot:activator="{ on, attrs }">
      <v-btn text v-bind="attrs" v-on="on" color="orange">
        <span>({{ productsInCart.length }})</span>
        <v-icon>mdi-cart</v-icon>
      </v-btn>
    </template>
    <template v-slot:default="dialog">
      <v-card class="mb-2">
        <v-toolbar color="orange" class="white--text font-weight-medium"
          >Carrinho de vendas</v-toolbar
        >
        <v-card-text class="py-4">
          <v-row align-content="center" justify="center">
            <v-col
              align-self="center"
              cols="10"
              v-for="product in productsInCart"
              :key="product[0]"
            >
              <div class="d-flex justify-space-between">
                <p class="text-h5 text--primary">{{ product[1] }}</p>

                <!-- WARNING replace . por , -->
                <span>
                  <strong class="text--primary">R$: {{ product[3] }}</strong>
                </span>
              </div>
              <span class="mr-8">quantidade: {{ product[2] }}</span>
              <span class="mr-8">total: {{ product[2] * product[3] }}</span>
              <v-divider></v-divider>
            </v-col>
          </v-row>
        </v-card-text>
        <v-card-actions class="justify-end">
          <v-btn text @click="dialog.value = false">Close</v-btn>
          <v-btn text @click="dialog.value = false">Vender</v-btn>
        </v-card-actions>
      </v-card>
    </template>
  </v-dialog>
</template>

<script>
import { mapGetters } from "vuex";
export default {
  name: "Cart",
  computed: mapGetters(["productsInCart"]),
};
</script>

<style scoped>
.scroll {
  overflow: scroll;
}
</style>