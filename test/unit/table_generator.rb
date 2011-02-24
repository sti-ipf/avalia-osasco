require "test/test_helper"

class TableGeneratorTest < ActiveSupport::TestCase
  TEMP_DIRECTORY = File.expand_path "#{RAILS_ROOT}/tmp"
  def setup
    @emef_data = get_hash(11)
    @emei_data = get_hash(10)
    @creche_data = get_hash(10)
    @institutions = []
    (1..60).each{|i| @institutions << ["teste_#{i}",i]}
    @eleven_dimensions = (1..11).collect
    @ten_dimensions = (1..10).collect
  end

  def get_hash(last_dimension)
    hash = {}
    (1..last_dimension).each do |dimension|
      (1..60).each do |institution|
        institution = "teste_#{institution}"
        hash[institution] = {} if hash[institution].nil?
        hash[institution][dimension] = [0.3, 0.5, 0.7].shuffle.first
      end
    end
    hash
  end

  test "gerar tabela com 11 dimensões (EMEF)" do
    UniFreire::Tables::Generator.build_html(@emef_data, @institutions, @eleven_dimensions)
    table_file = File.new(File.join(TEMP_DIRECTORY,'tabela.html'))
    UniFreire::Tables::Generator.send(:convert_html_to_pdf,table_file, "tabela_11_dimensoes_TESTE")
  end

  test "gerar tabela com 10 dimensões (EMEI e Creche)" do
    UniFreire::Tables::Generator.build_html(@emef_data, @institutions, @ten_dimensions)
    table_file = File.new(File.join(TEMP_DIRECTORY,'tabela.html'))
    UniFreire::Tables::Generator.send(:convert_html_to_pdf,table_file, "tabela_10_dimensoes_TESTE")
  end

  test "gerar legenda com 57 escolas" do
    UniFreire::Tables::Generator.build_legends(@institutions, "Unidades Escolares TESTE")
    table_file = File.new(File.join(TEMP_DIRECTORY,'legenda.html'))
    UniFreire::Tables::Generator.send(:convert_html_to_pdf,table_file, "legenda_TESTE")
  end

end

