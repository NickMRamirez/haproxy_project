websites_number = node['web']['count']

1.upto(websites_number) do |num|
  webpage_content = %Q{
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="utf-8" /> 
        <title>Web #{num}</title>
      </head>
      <body>
        <h1>NGINX Page</h1>
        <p>Web #{num}</p>
      </body>
    </html>
  }

  file "/tmp/index#{num}.html" do
    content webpage_content
  end
end