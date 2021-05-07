require 'rails_helper'

RSpec.feature "Projects", type: :feature do
  #start of should pass scenario
  scenario "should pass" do
    visit new_user_session_path
    find(:xpath, '/html/body/div/a[1]').click #sign up button 1
    within(:xpath, '/html') do
      fill_in "user[email]", with: "norman@hotmail.com"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      find(:xpath, '/html/body/div/form/div[4]/input').click #register button 1
    end
    visit new_project_path 
    within("form") do
      fill_in "Description", with: "Description can't be blank"
      fill_in "Title", with: "Title can't be blank"
    end
    find(:xpath, '/html/body/div/div[1]/form/div/table/tbody/tr[5]/td[1]/input').click #create button 1
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Title can't be blank")
  end #end of should pass scenario

  #start of should pass scenario
  scenario "Should pass Update project" do
    visit new_user_session_path
    find(:xpath, '/html/body/div/a[1]').click #sign up button 2
    within(:xpath, '/html') do
      fill_in "user[email]", with: "norman@hotmail.com"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      find(:xpath, '/html/body/div/form/div[4]/input').click  #register button 2
    end

    visit new_project_path 

    within("form") do
      fill_in "Description", with: "Description can't be blank"
      fill_in "Title", with: "Title can't be blank"
    end

    find(:xpath, '/html/body/div/div[1]/form/div/table/tbody/tr[5]/td[1]/input').click #create button 2

    visit projects_path
    find(:xpath, '/html/body/div/div[2]/div[2]/table/tbody/tr[1]/td[4]/a').click #edit button 1

    within("form") do
        fill_in "Description", with: "New description content"
        fill_in "Title", with: "New Title"
      end
    find(:xpath, '/html/body/div/div[1]/form/div/table/tbody/tr[5]/td[1]/input').click #create update edit button 1
    expect(page).to have_content("Project was successfully updated")
    
    #Should fail test  
    visit projects_path
    find(:xpath, '/html/body/div/div[2]/div[2]/table/tbody/tr[1]/td[4]/a').click #edit button 2

    
    within("form") do
      fill_in "Description", with: ""
      fill_in "Title", with: ""
    end

    find(:xpath, '/html/body/div/div[1]/form/div/table/tbody/tr[5]/td[1]/input').click #create update edit button 2
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Title can't be blank")
  end #end of update scenario

  #start of destroy a project test
  scenario "should pass destroy project" do
    visit new_user_session_path
    find(:xpath, '/html/body/div/a[1]').click #sign up button 3
    within(:xpath, '/html') do
      fill_in "user[email]", with: "norman@hotmail.com"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      find(:xpath, '/html/body/div/form/div[4]/input').click #register button 3
    end
    visit new_project_path 
    within("form") do
      fill_in "Description", with: "Description can't be blank"
      fill_in "Title", with: "Title can't be blank"
    end
    find(:xpath, '/html/body/div/div[1]/form/div/table/tbody/tr[5]/td[1]/input').click #create button 3
    
    visit projects_path
    find(:xpath, '/html/body/div/div[2]/div[2]/table/tbody/tr[1]/td[5]/a').click #destroy button 1
    expect(page).to have_content("Project was successfully destroyed")
    expect(Project.count).to eq(0)
  end #end of destroy scenario
end
