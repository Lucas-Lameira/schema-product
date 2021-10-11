<template>
   <div>
      <h1 class="my-5 text-center orange--text">Meus produtos</h1>

         


      


      <v-container>                     
         <v-btn @click="orderByCategoty('bebida')">
            bebida
         </v-btn>
         <v-btn>
            comida
         </v-btn>
            
         <v-row>

            <v-col 
               cols="12"
               md="6"
               lg="4"
               v-for="product in products" 
               :key="product[0]"
            >
              <v-card
                  class="mx-auto"
                  max-width="344"
               >
                  <v-card-text>
                     <div class="d-flex justify-space-between">
                        <span class="text-h5 text--primary">{{product[1]}}</span>
                        <v-chip
                           v-if="product[5] === 1"
                           class="ml-2"
                           color="white"
                           text-color="red"
                           small
                        >
                           {{product[2]}} qtd
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

                     <p>Quantidade:{{ product[2]}}</p>
                     <div class="text--primary">R$: {{product[3]}}</div>
                  </v-card-text>
                  <v-card-actions>
                     <v-btn
                     text
                     color="orange"
                  >
                     vender
                     </v-btn>
                  </v-card-actions>
               </v-card>
            </v-col>
         </v-row>
      </v-container>
      <v-btn
         v-show="!hidden"
         color="orange"
         dark
         absolute
         bottom
         right
         fab
         fixed
         class="mb-16 mr-16"
      >
         <v-icon>mdi-plus</v-icon>
      </v-btn>

   </div>   
</template>

<script>
   /* import axios from 'axios'; */

   export default {
      name: 'product',
      data(){
         return {
           /*  products: null */
           hidden: false,
           products: null,
           filterd: []
         }
      },
      methods: {
         orderByCategoty(category){
            this.filterd = this.products
            this.products = this.products.filter(product => {
               return product[7] == category
            })
         },
      },
      mounted(){
         console.log("hello")
         this.products = [
            [1, 'agua mineral marcax 20L', 19, '7.00', 10, 0, 1, 'bebida'],
            [2, 'macarrao legal 250g', 14, '3.50', 5, 0, 2, 'comida'],
            [3, 'cerveja skola beet', 41, '3.28', 30, 0, 1, 'bebida'],
            [4, 'papel higienio 6 rolos', 15, '4.50', 8, 0, 4, 'higiene'],
            [5, 'arroz tia joelma 1kg', 26, '6.20', 6, 0, 2, 'comida'],
            [6, 'cortador de unha', 12, '8.88', 2, 0, 3, 'utensilios'],
            [7, 'feijão galopero 500g', 17, '4.99', 10, 0, 2, 'comida'],
            [8, 'café desunião', 14, '5.06', 6, 0, 1, 'bebida'],
            [10, 'Alicade de unha', 5, '7.80', 3, 0, 3, 'utensilios'],
            [12, 'farinha', 5, '7.80', 3, 0, 3, 'utensilios'],
            [13, 'coca cola zero', 15, '7.80', 15, 1, 1, 'bebida'],
            [14, 'Heine quem', 36, '7.90', 15, 0, 1, 'bebida'],
            [15, 'suco de pera', 5, '7.90', 10, 0, 1, 'bebida'],
            [16, 'suco de biribá', 5, '7.90', 10, 1, 1, 'bebida'],
            [17, 'Miojo tailandes', 0, '2.50', 10, 1, 2, 'comida'],
            [20, 'Bombom de chocolate sonho de funk', 38, '1.00', 6, 0, 2, 'comida'],
            [21, 'teste', 0, '2.50', 10, 1, 2, 'comida'],
            [22, 'teste3', 3, '2.00', 2, 0, 4, 'higiene'],
            [23, 'teste4', 3, '2.00', 2, 0, 4, 'higiene'],
            [24, 'teste5', 3, '2.00', 2, 0, 4, 'higiene'],
            [25, 'teste6', 3, '2.00', 2, 0, 4, 'higiene'],
            [26, 'teste7', 3, '2.00', 2, 0, 4, 'higiene'],
            [27, 'teste8', 3, '2.00', 2, 0, 4, 'higiene'],
            [28, 'teste9', 3, '2.00', 2, 0, 4, 'higiene'],
            [29, 'teste10', 3, '2.00', 2, 0, 4, 'higiene'],
            [30, 'teste110', 3, '2.00', 5, 1, 4, 'higiene'],
            [33, 'tes0', 3, '2.00', 5, 1, 4, 'higiene'],
            [40, 'repelente', 9, '4.75', 3, 0, 1, 'bebida'],
            [43, 'teste200', 0, '2.50', 10, 1, 2, 'comida'],
         ]
      }
   }
</script>
