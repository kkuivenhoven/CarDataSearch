require "application_system_test_case"

class CocheDatosTest < ApplicationSystemTestCase
  setup do
    @coche_dato = coche_datos(:one)
  end

  test "visiting the index" do
    visit coche_datos_url
    assert_selector "h1", text: "Coche Datos"
  end

  test "creating a Coche dato" do
    visit coche_datos_url
    click_on "New Coche Dato"

    click_on "Create Coche dato"

    assert_text "Coche dato was successfully created"
    click_on "Back"
  end

  test "updating a Coche dato" do
    visit coche_datos_url
    click_on "Edit", match: :first

    click_on "Update Coche dato"

    assert_text "Coche dato was successfully updated"
    click_on "Back"
  end

  test "destroying a Coche dato" do
    visit coche_datos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Coche dato was successfully destroyed"
  end
end
