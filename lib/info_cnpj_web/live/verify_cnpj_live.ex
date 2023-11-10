defmodule InfoCnpjWeb.VerifyCnpjLive do
  use InfoCnpjWeb, :live_view

  alias InfoCnpj.Companies
  alias InfoCnpj.Companies.Company

  def mount(socket) do
    changeset = Companies.change_company(%Company{})

    socket =
      assign(
        socket,
        form: to_form(changeset)
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h2>Type the CNPJ in the field below</h2>
    <.form for={@form} phx-submit="verify-cnpj">
      <.input field={@form[:cnpj]} phx-change="validate" phx-debounce="blur" />
      <.button>Verify</.button>
    </.form>
    """
  end

  def handle_event("validate", %{"cnpj" => cnpj}, socket) do
    changeset =
      %Company{}
      |> Companies.change_company(cnpj)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
