class Login

  def self.login(user_loc_type, user_locator, username, pass_loc_type, pass_locator, password, submit_loc_type, submit_locator)
    $driver.find_element(user_loc_type.to_sym, user_locator).send_keys username
    $driver.find_element(pass_loc_type.to_sym, pass_locator).send_keys password
    $driver.find_element(submit_loc_type.to_sym, submit_locator).click
  end

  def self.forgot_password(user_loc_type, user_locator, username, submit_loc_type, submit_locator)
    $driver.find_element(user_loc_type.to_sym, user_locator).send_keys username
    $driver.find_element(submit_loc_type.to_sym, submit_locator).click
  end

end