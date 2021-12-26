require "test_helper"

class CocheDatosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coche_dato = coche_datos(:one)
  end

  test "should get index" do
    get coche_datos_url
    assert_response :success
  end

  test "should get new" do
    get new_coche_dato_url
    assert_response :success
  end

  test "should create coche_dato" do
    assert_difference('CocheDato.count') do
      post coche_datos_url, params: { coche_dato: {  } }
    end

    assert_redirected_to coche_dato_url(CocheDato.last)
  end

  test "should show coche_dato" do
    get coche_dato_url(@coche_dato)
    assert_response :success
  end

  test "should get edit" do
    get edit_coche_dato_url(@coche_dato)
    assert_response :success
  end

  test "should update coche_dato" do
    patch coche_dato_url(@coche_dato), params: { coche_dato: {  } }
    assert_redirected_to coche_dato_url(@coche_dato)
  end

  test "should destroy coche_dato" do
    assert_difference('CocheDato.count', -1) do
      delete coche_dato_url(@coche_dato)
    end

    assert_redirected_to coche_datos_url
  end
end
