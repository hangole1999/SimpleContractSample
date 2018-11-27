#include <eosiolib/eosio.hpp>
#include <eosiolib/print.hpp>

using namespace eosio;

class simplecontract : public eosio::contract {
  public:
      using contract::contract;

      /// @abi action 
      void setdata( int64_t data ) {
         print( data );
      }

      void callbackonsetdata( int64_t data ) {
         print( data );
      }
};

EOSIO_ABI( simplecontract, (setdata) (callbackonsetdata) )
