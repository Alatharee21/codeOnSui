import { useMemo, useState } from 'react'
import './App.css'

function App() {
  const [title, setTitle] = useState('')
  const [description, setDescription] = useState('')
  const [expiration, setExpiration] = useState('')
  const [proposals, setProposals] = useState([])
  const [feedback, setFeedback] = useState('')

  const canSubmit = title.trim() && description.trim() && expiration

  const sortedProposals = useMemo(
    () => [...proposals].sort((a, b) => b.createdAt - a.createdAt),
    [proposals],
  )

  const handleCreateProposal = (event) => {
    event.preventDefault()

    if (!canSubmit) {
      setFeedback('Please fill in every field.')
      return
    }

    const newProposal = {
      id: Date.now().toString(),
      title: title.trim(),
      description: description.trim(),
      createdAt: Date.now(),
      expirationDate: new Date(expiration).getTime(),
      votedYesCount: 0,
      votedNoCount: 0,
    }

    setProposals((current) => [newProposal, ...current])
    setTitle('')
    setDescription('')
    setExpiration('')
    setFeedback('Proposal created locally. Connect to Sui to submit on chain.')
  }

  const handleVote = (proposalId, type) => {
    setProposals((current) =>
      current.map((proposal) => {
        if (proposal.id !== proposalId) return proposal
        return {
          ...proposal,
          votedYesCount:
            type === 'yes' ? proposal.votedYesCount + 1 : proposal.votedYesCount,
          votedNoCount:
            type === 'no' ? proposal.votedNoCount + 1 : proposal.votedNoCount,
        }
      }),
    )
  }

  return (
    <main className="app-shell">
      <header className="hero-panel">
        <div>
          <p className="eyebrow">Voting protocol</p>
          <h1>Create proposals and vote</h1>
          <p className="hero-copy">
            A simple React UI for your Sui voting contract. Add proposals, review
            expiration dates, and cast votes locally before integrating chain calls.
          </p>
        </div>
      </header>

      <section className="form-panel">
        <form className="proposal-form" onSubmit={handleCreateProposal}>
          <h2>New proposal</h2>

          <label>
            Title
            <input
              value={title}
              onChange={(event) => setTitle(event.target.value)}
              placeholder="Proposal title"
            />
          </label>

          <label>
            Description
            <textarea
              value={description}
              onChange={(event) => setDescription(event.target.value)}
              placeholder="Short proposal description"
              rows={4}
            />
          </label>

          <label>
            Expiration date
            <input
              type="datetime-local"
              value={expiration}
              onChange={(event) => setExpiration(event.target.value)}
            />
          </label>

          <div className="form-actions">
            <button type="submit" disabled={!canSubmit}>
              Create proposal
            </button>
            <span className="hint">This form currently stores proposals locally.</span>
          </div>

          {feedback && <p className="feedback">{feedback}</p>}
        </form>

        <div className="proposal-summary">
          <h2>Proposal activity</h2>
          <p>
            Create proposals and vote yes or no. When ready, wire these handlers to
            your Sui move calls using package and module metadata.
          </p>
          <div className="summary-grid">
            <div>
              <span>{proposals.length}</span>
              <p>Proposals created</p>
            </div>
            <div>
              <span>
                {proposals.reduce((sum, proposal) => sum + proposal.votedYesCount, 0)}
              </span>
              <p>Yes votes</p>
            </div>
            <div>
              <span>
                {proposals.reduce((sum, proposal) => sum + proposal.votedNoCount, 0)}
              </span>
              <p>No votes</p>
            </div>
          </div>
        </div>
      </section>

      <section className="proposal-list">
        <h2>Active proposals</h2>
        {sortedProposals.length === 0 ? (
          <div className="empty-state">
            No proposals yet. Create one to begin testing the voting flow.
          </div>
        ) : (
          <div className="proposal-grid">
            {sortedProposals.map((proposal) => (
              <article key={proposal.id} className="proposal-card">
                <div className="proposal-header">
                  <h3>{proposal.title}</h3>
                  <p>{proposal.description}</p>
                </div>
                <div className="proposal-meta">
                  <span>
                    Expires{' '}
                    {new Date(proposal.expirationDate).toLocaleString()}
                  </span>
                  <span>
                    {new Date(proposal.expirationDate).getTime() < Date.now()
                      ? 'Expired'
                      : 'Open'}
                  </span>
                </div>
                <div className="proposal-votes">
                  <div>
                    <strong>{proposal.votedYesCount}</strong>
                    <span>Yes</span>
                  </div>
                  <div>
                    <strong>{proposal.votedNoCount}</strong>
                    <span>No</span>
                  </div>
                </div>
                <div className="proposal-actions">
                  <button type="button" onClick={() => handleVote(proposal.id, 'yes')}>
                    Vote yes
                  </button>
                  <button type="button" onClick={() => handleVote(proposal.id, 'no')}>
                    Vote no
                  </button>
                </div>
              </article>
            ))}
          </div>
        )}
      </section>
    </main>
  )
}

export default App
