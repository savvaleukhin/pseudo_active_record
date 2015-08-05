require_relative "../lib/pseudo_active_record"

describe PseudoActiveRecord::Table do
  let(:table) { PseudoActiveRecord::Table.new(name: "articles") }
  let(:db) { PStore.new("articles.pstore") }


  it 'retrieves column information' do
  #  columns = table.columns
  #  expect(columns.count).to eq 3
  end

  it 'can create a row' do
    params = { title: "Article 1", body: "Body of article 1" }

    article = table.insert(params)
    record = table.where(id: article.id)

    expect(record[:id]).to eq 1
    expect(record[:title]).to eq params[:title]
    expect(record[:body]).to eq params[:body]
  end

  it 'can delete a row' do
    params = { title: "Article 1", body: "Body of article 1" }

    article = table.insert(params)
    table.delete(id: article.id)

    expect(table.where(id: article.id)).to be_empty
  end

  it 'can update a row' do
    params = { title: "Article 1", body: "Body of article 1" }

    article = table.insert(params)
    table.update
  end
end
