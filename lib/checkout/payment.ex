defmodule BKashEx.Checkout.Payment do
  alias BKashEx.Checkout.Credentials

  @type create_payment_input_type :: %{
          amount: String.t(),
          currency: String.t(),
          intent: String.t(),
          merchant_invoice_number: String.t()
        }
  @type create_payment_output_type :: %{
          paymentID: String.t(),
          createType: String.t(),
          orgLogo: String.t(),
          orgName: String.t(),
          transactionStatus: String.t(),
          amount: String.t(),
          currency: String.t(),
          intent: String.t(),
          merchantInvoiceNumber: String.t()
        }

  @suffix "checkout/payment/create"
  @spec create(create_payment_input_type, Credentials.authorization_header_type()) ::
          {:ok, create_payment_output_type} | nil | Exception.t()
  def create(_input, _headers) do
    raise "Implement me " <> @suffix
  end
end
