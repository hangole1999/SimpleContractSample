#include <eosiolib/eosio.hpp>
#include <eosiolib/print.hpp>

using namespace eosio;

class simplectrc : public eosio::contract {
  public:
      using contract::contract;

      int64_t data;

      /// @abi action
      void setdatacore( int64_t data ) {
         this->data = data;

         print("{\"from\": \"simplectr\",\"to\": \"simplectr\",\"name\": \"cbsetdata\",\"data\": ");
         print(data);
         print("}");
      }
};

EOSIO_ABI( simplectrc, (setdatacore) )
