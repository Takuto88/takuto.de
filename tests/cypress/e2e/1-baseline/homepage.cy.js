describe('Visual Testing Regression', () => {

  it('Renders the homepage unchanged', () =>{

  cy.visit("/")
  cy.compareSnapshot('Home Page', {
    capture: 'viewport',
    errorThreshold: 0.5
  });

})

})