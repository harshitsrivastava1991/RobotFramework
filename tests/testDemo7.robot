*** Settings ***
Library       Collections
Library       RequestsLibrary

*** Variables ***
${base_url}         https://rahulshettyacademy.com
${book_ID}
${book_name}    Robot Framework


*** Test Cases ***
Play around with Dictionary
    [Tags]      API
    &{data}=    Create Dictionary      name=rahulshetty     course=robot       website=rahulshettyacademy.com
    log     ${data}
    Dictionary Should Contain Key     ${data}     name
    log     ${data}[name]
    ${url}=     Get From Dictionary     ${data}     website
    log   ${url}


Add Book into Library DataBase
       &{req_body}=  Create Dictionary    name=${book_name}        isbn=247113     aisle=324534        author=Harshit
       ${response}=     POST        ${base_url}/Library/Addbook.php     json=${req_body}    expected_status=200
       Log    ${response.json()}
       #if i want to check if the response contains ID or not
       Dictionary Should Contain Key    ${response.json()}    ID
       #if i want to extract that book id in the output
       ${book_ID}=    Get From Dictionary    ${response.json()}    ID 
       Set Global Variable    ${book_ID}
       Log  ${book_ID}
       Should Be Equal As Strings    successfully added    ${response.json()}[Msg]
       Status Should Be    200    ${response}

Get the book details which got added-Get Request
    ${get_response}=    GET    ${base_url}/Library/GetBook.php    params=ID=${book_ID}    expected_status=200
    Log    ${get_response.json()}
    Should Be Equal As Strings    ${book_name}    ${get_response.json()}[0][book_name]

Delete the book from database
    &{delete_req}=    Create Dictionary    ID=${book_ID}
    ${delete_response}=    POST    ${base_url}/Library/DeleteBook.php    json=${delete_req}    expected_status=200
    Log    ${delete_response.json()}
    Should Be Equal As Strings    book is successfully deleted    ${delete_response.json()}[msg]

