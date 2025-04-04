import express from 'express'
const app = express();
app.use(express.json());
app.use(express.static('angular-app/dist/angular-app/browser'));
const port = process.env.PORT || 8080;
app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});

app.get('/api/pirates/:id', (req, res) => {
  const id = req.params.id;
  const pirate = getPirate(id);
  if (!pirate) {
    res.status(404).send({ error: `Pirate ${id} not found`});
  } else {
    res.send({ data: pirate });
  }
})

function getPirate(id) {
  const pirates = [
    { id: 1, name: 'Blackbeard', active: '1245-12-12', country: 'USA'},
    { id: 2, name: 'Redbeard', active: '1350-12-12', country: 'USA'}
    ];
  return pirates.find(p => p.id == id);
}