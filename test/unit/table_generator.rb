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
    @eleven_dimensions << 12
    @ten_dimensions = (1..10).collect
    @ten_dimensions << 12
  end

  def get_hash(last_dimension)
    hash = {}
    (1..60).each do |institution|
      institution = "teste_#{institution}"
      hash[institution] = {} if hash[institution].nil?
      (1..last_dimension).each do |dimension|
        hash[institution][dimension] = [0.3, 0.5, 0.7].shuffle.first
      end
      hash[institution][12] = [0.3, 0.5, 0.7].shuffle.first #índice geral
    end
    hash
  end

  test "gerar tabela com 11 dimensões (EMEF)" do
    file_name = "tabela_11_dimensoes_TESTE"
    UniFreire::Tables::Generator.build_html(@emef_data, @institutions, @eleven_dimensions, file_name)
    table_file = File.new(File.join(TEMP_DIRECTORY,"#{file_name}.html"))
    UniFreire::Tables::Generator.send(:convert_html_to_pdf,table_file, file_name)
  end

  test "gerar tabela com 10 dimensões (EMEI e Creche)" do
    file_name = "tabela_10_dimensoes_TESTE"
    UniFreire::Tables::Generator.build_html(@emef_data, @institutions, @ten_dimensions, file_name)
    table_file = File.new(File.join(TEMP_DIRECTORY,"#{file_name}.html"))
    UniFreire::Tables::Generator.send(:convert_html_to_pdf,table_file, file_name)
  end

  test "gerar legenda com 57 escolas" do
    file_name = "legenda_TESTE"
    UniFreire::Tables::Generator.build_legends(@institutions, "Unidades Escolares TESTE", file_name)
    table_file = File.new(File.join(TEMP_DIRECTORY,"#{file_name}.html"))
    UniFreire::Tables::Generator.send(:convert_html_to_pdf,table_file, "legenda_TESTE")
  end

end

