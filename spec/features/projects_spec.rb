require 'rails_helper'

RSpec.feature "Projects", type: :feature do
  #start of should pass scenario
  scenario "should pass" do
    visit new_user_session_path
    find(:xpath, '/html/body/div/a[1]').click #sign up button
    within(:xpath, '/html') do
      fill_in "user[email]", with: "norman@hotmail.com"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      find(:xpath, '/html/body/div/form/div[4]/input').click #register button
    end
    visit new_project_path 
    within("form") do
      fill_in "Description", with: "Description can't be blank"
      fill_in "Title", with: "Title can't be blank"
    end
    find(:xpath, '/html/body/div/form/div[3]/input').click #create button
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Title can't be blank")
  end #end of should pass scenario

  #start of should pass scenario
  scenario "Should pass Update project" do
    visit new_user_session_path
    find(:xpath, '/html/body/div/a[1]').click #sign up button
    within(:xpath, '/html') do
      fill_in "user[email]", with: "norman@hotmail.com"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      find(:xpath, '/html/body/div/form/div[4]/input').click  #register button
    end

    visit new_project_path 

    within("form") do
      fill_in "Description", with: "Description can't be blank"
      fill_in "Title", with: "Title can't be blank"
    end

    find(:xpath, '/html/body/div/form/div[3]/input').click #create button

    visit projects_path
    find(:xpath, '/html/body/div/div/div[2]/table/tbody/tr/td[4]/a').click #edit button

    within("form") do
        fill_in "Description", with: "New description content"
        fill_in "Title", with: "New Title"
      end
    find(:xpath, '/html/body/div/form/div[3]/input').click #create button
    expect(page).to have_content("Project was successfully updated")
    
    #Should fail test  
    visit projects_path
    find(:xpath, '/html/body/div/div/div[2]/table/tbody/tr/td[4]/a').click #edit button

    
    within("form") do
      fill_in "Description", with: ""
      fill_in "Title", with: ""
    end

    find(:xpath, '/html/body/div/form/div[3]/input').click #create button
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Title can't be blank")
  end #end of update scenario

  #start of destroy a project test
  scenario "should pass destroy project" do
    visit new_user_session_path
    find(:xpath, '/html/body/div/a[1]').click #sign up button
    within(:xpath, '/html') do
      fill_in "user[email]", with: "norman@hotmail.com"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      find(:xpath, '/html/body/div/form/div[4]/input').click #register button
    end
    visit new_project_path 
    within("form") do
      fill_in "Description", with: "Description can't be blank"
      fill_in "Title", with: "Title can't be blank"
    end
    find(:xpath, '/html/body/div/form/div[3]/input').click #create button
    
    visit projects_path
    find(:xpath, '/html/body/div/div/div[2]/table/tbody/tr/td[5]/a').click #destroy button
    expect(page).to have_content("Project was successfully destroyed")
    expect(Project.count).to eq(0)
  end #end of destroy scenario
end
