#undef kILSimAllowSimulatedStoreKit
#undef kILSimReplaceRealStoreKit
#define kILSimAllowSimulatedStoreKit 1
#define kILSimReplaceRealStoreKit 1

#if kILSimAllowSimulatedStoreKit

	#if kILSimReplaceRealStoreKit

		#define SKPaymentTransaction ILSimSKPaymentTransaction
		#define SKProductsRequest ILSimSKProductsRequest
		#define SKPaymentQueue ILSimSKPaymentQueue
		#define SKRequest ILSimSKRequest
		#define SKProduct ILSimSKProduct
		#define SKPayment ILSimSKPayment
		#define SKProductsRequestDelegate ILSimSKProductsRequestDelegate
		#define SKPaymentTransactionObserver ILSimSKPaymentTransactionObserver
		#define SKRequestDelegate ILSimSKRequestDelegate
		#define SKProductsResponse ILSimSKProductsResponse

		#define SKPaymentTransactionStatePurchased kILSimSKPaymentTransactionStatePurchased
		#define SKPaymentTransactionStateFailed kILSimSKPaymentTransactionStateFailed
		#define SKPaymentTransactionStatePurchasing kILSimSKPaymentTransactionStatePurchasing
		#define SKPaymentTransactionStateRestored kILSimSKPaymentTransactionStateRestored

		#define SKErrorDomain kILSimSKErrorDomain
		#define SKErrorUnknown kILSimSKErrorUnknown 
		#define SKErrorClientInvalid kILSimSKErrorClientInvalid 
		#define SKErrorPaymentCancelled kILSimSKErrorPaymentCancelled 
		#define SKErrorPaymentInvalid kILSimSKErrorPaymentInvalid 
		#define SKErrorPaymentNotAllowed kILSimSKErrorPaymentNotAllowed 

	#endif

#endif
