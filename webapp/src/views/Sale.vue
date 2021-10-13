<template>
  <div>
    <h1 class="my-5 text-center orange--text">Produtos para venda</h1>

    <v-btn class="pa-2 white">
      <span>cart </span>
      <span> {{ cart.length }} </span>
    </v-btn>

    <v-container>
      <v-row>
        <v-col
          cols="12"
          lg="4"
          v-for="product in productsForSale"
          :key="product[0]"
        >
          <v-card class="mx-auto">
            <v-card-text>
              <div class="d-flex justify-space-between">
                <span class="text-h5 text--primary">{{ product[1] }}</span>

                <span v-if="product[5] == 1" class="pa-2 red white--text">
                  low
                </span>
                <span v-else class="pa-2 green white--text"> OK </span>
              </div>

              <span>Quantidade:{{ product[2] }}</span>
              <div class="text--primary">R$: {{ product[3] }}</div>
            </v-card-text>

            <v-card-actions>
              <v-btn text color="orange" @click="addToCart(product[0])">
                Add carrinho
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import api from "../services/api";
import NewProductPopup from "../components/NewProductPopup.vue";

export default {
  name: "sale",
  components: {
    NewProductPopup,
  },
  data() {
    return {
      productsForSale: [],
      hidden: false,
      cart: [],
    };
  },
  mounted() {
    this.productsForSale = [
      [1, "agua mineral marcax 20L", 19, "7.00", 1, 0],
      [10, "Alicade de unha", 5, "7.80", 3, 0],
      [5, "arroz tia joelma 1kg", 26, "6.20", 2, 0],
      [20, "Bombom de chocolate sonho de funk", 38, "1.00", 2, 0],
      [8, "café desunião", 14, "5.06", 1, 0],
      [3, "cerveja skola beet", 41, "3.28", 1, 0],
      [13, "coca cola zero", 15, "7.80", 1, 1],
      [6, "cortador de unha", 12, "8.88", 3, 0],
      [12, "farinha", 5, "7.80", 3, 0],
      [7, "feijão galopero 500g", 17, "4.99", 2, 0],
      [14, "Heine quem", 36, "7.90", 1, 0],
      [2, "macarrao legal 250g", 14, "3.50", 2, 0],
      [4, "papel higienio 6 rolos", 15, "4.50", 4, 0],
      [40, "repelente", 9, "4.75", 1, 0],
      [16, "suco de biribá", 5, "7.90", 1, 1],
      [15, "suco de pera", 5, "7.90", 1, 0],
      [33, "tes0", 3, "2.00", 4, 1],
      [29, "teste10", 3, "2.00", 4, 0],
      [30, "teste110", 3, "2.00", 4, 1],
      [28, "teste9", 3, "2.00", 4, 0],
    ];
  },
  /*  async mounted() {
    try{
      const result = await api.get("http://127.0.0.1:5000/products");
      this.productsForSale = result.data;
    }catch(error){
      console.log(error)
    }
  }, */
  computed: {
    orderByCategory(id) {
      this.productsForSale.filter((product) => {
        return product[4] === id;
      });
    },
  },
  methods: {
    addToCart(id) {
      // validar se o item ja está no carrinho
      for (let i = 0; i < this.productsForSale.length; i++) {
        if (this.productsForSale[i].includes(id)) {
          this.cart.push(this.productsForSale[i]);
          break;
        }
      }

      console.log(this.cart);
    },
  },
};
</script>


