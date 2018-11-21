#include <eosiolib/eosio.hpp>
#include <eosiolib/print.hpp>

using namespace eosio;

class simplectr : public eosio::contract {
  public:
      using contract::contract;

      int64_t data;

      /// @abi action
      void setdata( int64_t data ) {
         print( data );
      }

      void cbonsetdata( int64_t data ) {
         this->data = data;
         print( this->data );
      }
};

EOSIO_ABI( simplectr, (setdata) (cbonsetdata) )

