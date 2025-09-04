### A Pluto.jl notebook ###
# v0.20.14

using Markdown
using InteractiveUtils

# ╔═╡ 6a3d0a57-5934-47d8-9015-fa0eb465582f
using PlutoUI, Kroki, PlutoLinks, ShortCodes, PlutoSliderServer, PlutoTeachingTools, MarkdownLiteral, InteractiveUtils

# ╔═╡ b0dcbe50-9e2f-4650-b5d1-9bdbaa9c1c9e
md"# Bitcoin Transaction Protocol"

# ╔═╡ aee5f220-89d9-11f0-24d1-9fe74cca62d3
plantuml"""

title Bitcoin Transaction Protocol Flow

actor User
participant Wallet
participant "Bitcoin Node" as Node
participant Miner
database Blockchain

autonumber "<b>[0]"

User -> Wallet: Initiate Transaction (Amount, Recipient)
activate Wallet
Wallet -> Wallet: Create & Sign Transaction\nwith User's Private Key
Wallet -> Node: Broadcast Signed Transaction
deactivate Wallet
activate Node

Node -> Node: Validate Transaction\n(Signature, UTXOs)
Node ->o Node: Propagate to other nodes
Node -> Miner: Add to Mempool
deactivate Node

activate Miner
Miner -> Miner: Select transactions from Mempool
Miner -> Miner: **Start Proof-of-Work**\n(Hashing block header + nonce)
note right: Race to find a hash\nbelow the target difficulty

== Block Found ==

Miner -> Node: Broadcast New Block
activate Node
deactivate Miner

Node -> Node: **Validate Block**\n(PoW, transaction validity)
Node -> Blockchain: Add Block to Chain
deactivate Node
note right: Transaction is now confirmed.
"""



# ╔═╡ 4dfd1f12-f334-443b-a6c3-87cf1e49d15b
graphviz"""
digraph BitcoinProtocol {
    // Graph settings for Dark Theme
    graph [
        rankdir=TB,
        splines=true,
        overlap=false,
        nodesep=0.6,
        ranksep=1.2,
        fontname="Helvetica, Arial, sans-serif",
        label="Simplified Bitcoin Protocol Flow",
        fontsize=20,
        bgcolor="#2E2E2E", // Dark background
        fontcolor="white"   // Light text for title
    ];

    // Default Node styles for Dark Theme
    node [
        shape=box,
        style="filled,rounded",
        fontname="Helvetica, Arial, sans-serif",
        fontsize=12,
        fontcolor="white", // Light text
        color="#E0E0E0"    // Light border
    ];

    // Default Edge styles for Dark Theme
    edge [
        fontname="Helvetica, Arial, sans-serif",
        color="#E0E0E0",    // Light edge lines
        fontcolor="#E0E0E0" // Light edge labels
    ];

    // Define nodes with dark theme colors
    User [label="User", shape=oval, fillcolor="#5D6D7E"];
    Wallet [label="Wallet Software", fillcolor="#5D6D7E"];
    Tx [label="New Transaction\n(Unconfirmed)", shape=note, fillcolor="#AF601A"];
    Mempool [label="Mempool\n(Queue of Unconfirmed Txs)", shape=cylinder, fillcolor="#154360"];
    Nodes [label="Full Nodes", shape=server, fillcolor="#1E8449"];
    Miners [label="Miners", shape=doublecircle, fillcolor="#6C3483", peripheries=2];
    PoW [label="Proof-of-Work\n(Hashing Contest)", shape=septagon, style=dashed, fillcolor="#922B21", color="white"];
    Block [label="New Block\n(with Txs)", shape=box3d, fillcolor="#78281F"];
    Blockchain [label="Blockchain\n(Distributed Ledger)", shape=folder, fillcolor="#145A32", height=1.5];

    // Define edges (relationships)
    subgraph cluster_creation {
        label="1. Transaction Creation";
        style=dashed;
        color="lightgray";
        fontcolor="lightgray";
        User -> Wallet [label="initiates"];
        Wallet -> Tx [label="creates & signs"];
    }

    subgraph cluster_propagation {
        label="2. Network Propagation";
        style=dashed;
        color="lightgray";
        fontcolor="lightgray";
        Tx -> Nodes [label="broadcasts to"];
        Nodes -> Mempool [label="adds to"];
        Nodes -> Nodes [label="relays Txs"];
    }

    subgraph cluster_mining {
        label="3. Mining & Consensus";
        style=dashed;
        color="lightgray";
        fontcolor="lightgray";
        Mempool -> Miners [label="selects Txs"];
        Miners -> PoW [label="competes to solve"];
        PoW -> Block [label="valid solution creates"];
        Tx -> Block [style=dotted, label="is included in"];
    }

    subgraph cluster_confirmation {
        label="4. Block Confirmation";
        style=dashed;
        color="lightgray";
        fontcolor="lightgray";
        Miners -> Nodes [label="broadcasts new Block"];
        Nodes -> Blockchain [label="validates & adds"];
        Block -> Blockchain [label="is appended to"];
    }

    // Final link to show the chain
    Blockchain -> Blockchain [label="previous blocks"];
}
"""

# ╔═╡ c677ae2c-04f4-4009-8f77-4a5537d52d32
md"# BioProtocol"

# ╔═╡ e174ee27-7f3e-4cda-993a-7f3e92e0c325
plantuml"""
title BioProtocol Network: Decentralized Biotech Funding Workflow

actor "Scientist / Innovator" as Scientist
participant "BioProtocol Platform" as Platform
participant "BIO Token Holders" as Community
participant "BioDAO"
database "Treasury & Liquidity Pool" as Treasury

autonumber "<b>[0]"

== I. Curation Phase ==
Scientist -> Platform: Submit Research Proposal
activate Scientist
deactivate Scientist

activate Platform
Platform -> Community: Announce New Proposal
note right: Community reviews proposal for\nscientific merit and potential impact.

Community -> Platform: **Stake BIO tokens** on proposal
note left: Staking signifies support and belief\nin the project's success.

Platform -> Platform: Tally staked support

alt Project receives sufficient support
    Platform --> Scientist: Proposal moves to funding phase
else Project fails to meet threshold
    Platform --> Scientist: Proposal rejected
    deactivate Platform
end


== II. Funding & Launch Phase ==
Platform -> Community: Initiate **Ignition Sale** for the new BioDAO
note right: Community members can now invest\nBIO tokens to fund the project directly.

Community -> Platform: Contribute BIO to purchase\nnew BioDAO tokens
Platform -> BioDAO: Transfer raised funds
activate BioDAO

BioDAO -> Scientist: Allocate funds for R&D

== III. Liquidity & Governance ==
Platform -> Treasury: Create Liquidity Pool\n(e.g., new BioDAO token / BIO)
note right: Enables trading and establishes\nmarket value for the new token.
deactivate Platform

Community -> BioDAO: Participate in Governance
note left: Token holders vote on key\nresearch milestones & decisions.

BioDAO -> BioDAO: **Execute Research & Development**
BioDAO --> Community: Report on scientific milestones
deactivate BioDAO
"""

# ╔═╡ aeaa2125-2718-41a7-981e-3740224b817c
graphviz"""
digraph BioProtocolWorkflow {
    // --- Graph Attributes ---
    bgcolor="#2E3440";
    fontcolor="white";
    fontname="Arial";
    label="BioProtocol Network: DeSci Funding & Governance";
    labelloc="t";
    fontsize=24;
    rankdir="TB";

    // --- Node Definitions ---
    // Define all nodes with their individual styles first for clarity.
    subgraph cluster_actors {
        label=""; color="#2E3440";
        Scientist [
            label="Scientist / Innovator", shape=box, style="filled,rounded",
            fillcolor="#A3BE8C", color="#D8DEE9", fontcolor="white"
        ];
        Community [
            label="BIO Token Holders\n(Community)", shape=box, style="filled,rounded",
            fillcolor="#A3BE8C", color="#D8DEE9", fontcolor="white"
        ];
    }

    subgraph cluster_systems {
        label=""; color="#2E3440";
        Platform [
            label="BioProtocol Platform", shape=component, style=filled,
            fillcolor="#88C0D0", fontcolor="white"
        ];
        BioDAO [
            label="New Project BioDAO", shape=tab, style=filled,
            fillcolor="#B48EAD", fontcolor="white"
        ];
        Treasury [
            label="Treasury & LP", shape=cylinder, style=filled,
            fillcolor="#5E81AC", fontcolor="white"
        ];
    }

    // --- Edge Definitions ---
    // Define all relationships between the nodes.
    edge [fontname="Arial", fontsize=10, fontcolor="white", color="#ECEFF4"];

    // Phase 1: Curation
    Scientist -> Platform [label="1. Submits Proposal"];
    Platform -> Community [label="2. Announces Proposal"];
    Community -> Platform [label="3. Stakes BIO Tokens\n(to show support)"];

    // Phase 2: Funding
    Platform -> Community [label="4. Initiates Ignition Sale", style=dashed];
    Community -> BioDAO [label="5. Contributes BIO to Fund DAO"];

    // Phase 3: Governance & Execution
    BioDAO -> Scientist [label="6. Allocates R&D Funds"];
    Platform -> Treasury [label="7. Creates Liquidity Pool (LP)"];
    Community -> BioDAO [label="8. Participates in Governance\n(Voting on milestones)"];
}
"""

# ╔═╡ 54afd7f3-00eb-4154-b88b-53c801abb100
md"# Gitcoin"

# ╔═╡ 3688e433-9ee4-4592-99ce-8f94b29a0ab0
plantuml"""
Of course. Gitcoin is an ecosystem with several moving parts, but its most well-known product is Gitcoin Grants, which uses a novel mechanism called Quadratic Funding.

Here is a PlantUML sequence diagram that describes the workflow for a typical Gitcoin Grants funding round. This process involves Grant Owners, community Donors, and the Gitcoin Platform, which calculates the matching funds.

Gitcoin Grants Workflow with Quadratic Funding
This diagram illustrates how a large matching pool is distributed based on the number of contributors to a project, not just the total amount contributed. This is the core of quadratic funding.

Code snippet

@startuml
!theme vibrant

title Gitcoin Grants: Quadratic Funding Workflow

actor "Grant Owner" as Owner
actor "Community Donor" as Donor
participant "Gitcoin Platform" as Platform
database "Smart Contracts" as Contracts
database "Matching Pool" as Pool

autonumber "<b>[0]"

== I. Setup Phase ==

Owner -> Platform: Create/Submit Grant Proposal
note right: Details the public good project\nand sets a funding goal.

Platform -> Platform: Vet and Approve Grant
Platform -> Pool: Grant becomes eligible for matching

== II. Funding Round (Live) ==

Donor -> Platform: Discover and Select Grant to support
activate Donor

Donor -> Platform: **Contribute Funds** (e.g., 1 DAI)
Platform -> Contracts: Process Donor's contribution
activate Contracts

Contracts -> Owner: Transfer direct contribution (1 DAI)
deactivate Contracts

Platform -> Platform: **Record Contribution**\n(1 Donor contributed 1 DAI)
note right of Platform
  The platform logs every unique contribution.
  This data is crucial for the matching calculation.
end note

Donor -> Platform: Contribute to other grants
deactivate Donor

== III. Round Ends & Fund Distribution ==

Platform -> Platform: **Calculate Quadratic Funding Match**
note right
  **Quadratic Funding (QF) Formula:**
  The match for a grant is proportional to the
  square of the sum of the square roots of
  each individual contribution.
  
  Match amount ≈ (Σ √contribution_i)²
  
  This heavily favors grants with a *broad*
  base of support (many small donors) over
  those with a few large donors.
end note

Platform -> Pool: Determine match amount for the Grant
activate Pool

Pool -> Contracts: Allocate matching funds
deactivate Pool
activate Contracts

Contracts -> Owner: Distribute calculated Matching Funds
deactivate Contracts

Owner -> Owner: Receive combined funds\n(Direct donations + QF Match)

"""

# ╔═╡ 09a4f87f-bddb-4db0-a943-829cda17d4d0
graphviz"""
digraph GitcoinGrantsWorkflow {
    // --- Graph Attributes ---
    bgcolor="#2E3440";
    fontcolor="white";
    fontname="Arial";
    label="Gitcoin Grants: Quadratic Funding Workflow";
    labelloc="t";
    fontsize=24;
    rankdir="TB";

    // --- Node Definitions & Styling ---
    node [style=filled, fontname="Arial", fontcolor="white"];

    subgraph cluster_actors {
        label="";
        color="#2E3440";
        node [shape=box, style="filled,rounded", fillcolor="#4C566A", color="#D8DEE9"];
        Owner [label="Grant Owner"];
        Donor [label="Community Donor"];
    }

    subgraph cluster_systems {
        label="";
        color="#2E3440";
        node [shape=cylinder, style=filled, fillcolor="#5E81AC", color="#ECEFF4"];
        Pool [label="Matching Pool"];
        Contracts [label="Smart Contracts"];

        node [shape=component, fillcolor="#88C0D0"];
        Platform [label="Gitcoin Platform"];
    }


    // --- Edge Styling ---
    edge [fontname="Arial", fontsize=10, fontcolor="white", color="#ECEFF4"];


    // --- Workflow Edges ---

    // Phase 1: Setup
    Owner -> Platform [label="1. Submits Grant Proposal"];

    // Phase 2: Funding Round
    Donor -> Platform [label="2. Contributes Funds"];
    Platform -> Contracts [label="3. Processes Donation"];
    Contracts -> Owner [label="4. Transfers Direct Donation"];

    // Phase 3: Distribution
    Platform -> Pool [label="5. Calculates & Requests QF Match", style=dashed, arrowhead=vee];
    Pool -> Contracts [label="6. Allocates Match"];
    Contracts -> Owner [label="7. Distributes QF Match"];

    // Explanatory note for QF
    {
        rank=same; Platform;
        QF_Note [
            label="Quadratic Funding (QF) Calculation\nhappens here.\nFavors number of donors over total amount.",
            shape=note, fillcolor="#EBCB8B", fontcolor="#3B4252", fontsize=11
        ];
        Platform -> QF_Note [style=invis];
    }
}
"""

# ╔═╡ 7c759c32-1b47-4f3f-97c1-d638d52ee2af
md"# Autonomi Network"

# ╔═╡ 3b3998ad-9f1d-4ef7-a760-4d7edd6d5782
plantuml"""
!theme spacelab

title Autonomi Network: Data Upload (PUT) and Retrieval (GET) Flow

actor "User/Client" as Client
participant "Section Elders" as Elders
participant "Adults (Vaults)\n(Close Group)" as Vaults

box "Autonomi Network Section" #LightBlue
    participant Elders
    participant Vaults
end box

== Data Upload (PUT) ==

Client -> Client: 1. Self-Encrypt Data & Create DataMap
note right: Data is chunked, hashed, and encrypted locally.\nThe addresses of the chunks form a DataMap.

Client -> Elders: 2. PUT Request (DataMap)
note left: Client identifies the destination Section\nbased on the data's XOR address.

Elders -> Elders: 3. Achieve Consensus
note right: Elders validate the request and agree\non the storage location (a Close Group of Vaults).

Elders -> Vaults: 4. Instruct to Store Chunks
note right: Elders forward the data chunks to the\nresponsible Adult nodes (Vaults) in the section.

Vaults -> Vaults: 5. Store Data Chunks Redundantly
note left: Each Vault stores a chunk. The Close Group\nensures data is replicated for fault tolerance.

Vaults --> Elders: 6. Acknowledge Storage
Elders -> Client: 7. Confirm Successful Upload

== Data Retrieval (GET) ==

Client -> Elders: 8. GET Request (Data Address)
note left: Client requests data using its unique XOR address.

Elders -> Elders: 9. Locate Data
note right: Elders identify the Close Group of Vaults\nholding the requested data chunks.

Elders -> Vaults: 10. Request Data Chunks
Vaults --> Elders: 11. Return Data Chunks

Elders --> Client: 12. Return Data Chunks
Client -> Client: 13. Reassemble & Decrypt Data
note right: Client uses the DataMap to reassemble the\nchunks and decrypt the original file locally.

"""

# ╔═╡ 976e7588-6e3e-4617-a9ff-4100373b1aa4
plantuml"""
!theme spacelab

' Set layout direction
left to right direction

' Define packages to group components
package "User Interaction" #LightGrey {
  actor "User" as User
  component "Autonomi Client" as Client
}

package "Core Security Mechanisms" #LightBlue {
  component "Self-Authentication\n(BLS Distributed Key Gen)" as Auth
  component "Self-Encryption\n(Quantum-Secure)" as Encrypt
}

package "Data Handling" #LightYellow {
  file "Data"
  note "Data Chunks" as Chunks
  note "Data Map\n(on user device)" as DataMap
}

package "Decentralized Network" #LightGreen {
    node "Peer-to-Peer Network\n(Nodes on everyday devices)" as P2P_Network
    component "Networking Libraries\n(TCP/UDP based)" as Libs
}

package "Payments & Transfers" #LightCoral {
    component "Payments System\n(Digital Bearer Certificates)" as Payments
    database "Public 'Spend' Graph\n(DAG for Auditing)" as SpendGraph
}

' Define relationships between components
User --> Client : interacts with

Client --> Auth : handles
Client --> Data : uploads/downloads
Client --> Payments : initiates

Data --> Chunks : split into
Chunks --> Encrypt : is processed by
Encrypt --> DataMap : creates
Encrypt --> P2P_Network : sends encrypted chunks to

DataMap --> P2P_Network : points to chunks on

Payments --> SpendGraph : audited via
P2P_Network --> Libs : built on

"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
InteractiveUtils = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
Kroki = "b3565e16-c1f2-4fe9-b4ab-221c88942068"
MarkdownLiteral = "736d6165-7244-6769-4267-6b50796e6954"
PlutoLinks = "0ff47ea0-7a50-410d-8455-4348d5de0420"
PlutoSliderServer = "2fc8631c-6f24-4c5b-bca7-cbb509c42db4"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
ShortCodes = "f62ebe17-55c5-4640-972f-b59c0dd11ccf"

[compat]
Kroki = "~1.0.0"
MarkdownLiteral = "~0.1.2"
PlutoLinks = "~0.1.6"
PlutoSliderServer = "~1.5.0"
PlutoTeachingTools = "~0.4.5"
PlutoUI = "~0.7.71"
ShortCodes = "~0.3.6"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.6"
manifest_format = "2.0"
project_hash = "6b657ed0cecb11cd80b55c9aefdf4348054ed621"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.AbstractTrees]]
git-tree-sha1 = "2d9c9a55f9c93e8887ad391fbae72f8ef55e1177"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.4.5"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.BetterFileWatching]]
deps = ["Deno_jll", "JSON"]
git-tree-sha1 = "0d7ee0a1acad90d544fa87cc3d6f463e99abb77a"
uuid = "c9fd44ac-77b5-486c-9482-9798bd063cc6"
version = "0.1.5"

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "5ac098a7c8660e217ffac31dc2af0964a8c3182a"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "2.0.0"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "962834c22b66e32aa10f7611c08c8ca4e20749a9"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.8"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.CommonMark]]
deps = ["PrecompileTools"]
git-tree-sha1 = "351d6f4eaf273b753001b2de4dffb8279b100769"
uuid = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
version = "0.9.1"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "0037835448781bb46feb39866934e243886d756a"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.18.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.Compiler]]
git-tree-sha1 = "382d79bfe72a406294faca39ef0c3cef6e6ce1f1"
uuid = "807dbc54-b67e-4c79-8afb-eafe4df6f2e1"
version = "0.1.1"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "d9d26935a0bcffc87d2613ce14c527c99fc543fd"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.5.0"

[[deps.Configurations]]
deps = ["ExproniconLite", "OrderedCollections", "TOML"]
git-tree-sha1 = "4358750bb58a3caefd5f37a4a0c5bfdbbf075252"
uuid = "5218b696-f38b-4ac9-8b61-a12ec717816d"
version = "0.17.6"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Deno_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "cd6756e833c377e0ce9cd63fb97689a255f12323"
uuid = "04572ae6-984a-583e-9378-9577a1c2574d"
version = "1.33.4+0"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"
version = "1.11.0"

[[deps.DocStringExtensions]]
git-tree-sha1 = "7442a5dfe1ebb773c29cc2962a8980f47221d76c"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.5"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "d36f682e590a83d63d1c7dbd287573764682d12a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.11"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7bb1361afdb33c7f2b085aa49ea8fe1b0fb14e58"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.7.1+0"

[[deps.ExpressionExplorer]]
git-tree-sha1 = "4a8c0a9eebf807ac42f0f6de758e60a20be25ffb"
uuid = "21656369-7473-754a-2065-74616d696c43"
version = "1.1.3"

[[deps.ExproniconLite]]
git-tree-sha1 = "c13f0b150373771b0fdc1713c97860f8df12e6c2"
uuid = "55351af7-c7e9-48d6-89ff-24e801d99491"
version = "0.10.14"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FromFile]]
deps = ["Downloads", "Requires"]
git-tree-sha1 = "fd1b6f327472d0faf28b4d1fda8d9b582ab136df"
uuid = "ff7dd447-1dcb-4ce3-b8ac-22a812192de7"
version = "0.1.6"

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Zlib_jll"]
git-tree-sha1 = "38044a04637976140074d0b0621c1edf0eb531fd"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.1+0"

[[deps.Git]]
deps = ["Git_LFS_jll", "Git_jll", "JLLWrappers", "OpenSSH_jll"]
git-tree-sha1 = "824a1890086880696fc908fe12a17bcf61738bd8"
uuid = "d7ba0133-e1db-5d97-8f8c-041e4b3a1eb2"
version = "1.5.0"

[[deps.Git_LFS_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "bb8471f313ed941f299aa53d32a94ab3bee08844"
uuid = "020c3dae-16b3-5ae5-87b3-4cb189e250b2"
version = "3.7.0+0"

[[deps.Git_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "LibCURL_jll", "Libdl", "Libiconv_jll", "OpenSSL_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "cd06e503111a7c5ef1d4a339de6ccf5bd7437b32"
uuid = "f8c6e375-362e-5223-8a59-34ff63f689eb"
version = "2.51.0+0"

[[deps.Glob]]
git-tree-sha1 = "97285bbd5230dd766e9ef6749b80fc617126d496"
uuid = "c27321d9-0574-5035-807b-f59d2c89b15c"
version = "1.3.1"

[[deps.GracefulPkg]]
deps = ["Compat", "Pkg", "TOML"]
git-tree-sha1 = "698050b04f3cc0906d0817329d6e96484bf238eb"
uuid = "828d9ff0-206c-6161-646e-6576656f7244"
version = "2.3.0"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "ed5e9c58612c4e081aecdb6e1a479e18462e041e"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.17"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "0533e564aae234aff59ab625543145446d8b6ec2"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JSON3]]
deps = ["Dates", "Mmap", "Parsers", "PrecompileTools", "StructTypes", "UUIDs"]
git-tree-sha1 = "411eccfe8aba0814ffa0fdf4860913ed09c34975"
uuid = "0f8b85d8-7281-11e9-16c2-39a750bddbf1"
version = "1.14.3"

    [deps.JSON3.extensions]
    JSON3ArrowExt = ["ArrowTypes"]

    [deps.JSON3.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e95866623950267c1e4878846f848d94810de475"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.1.2+0"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "d8337622fe53c05d16f031df24daf0270e53bc64"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.10.5"

[[deps.Kroki]]
deps = ["Base64", "CodecZlib", "DocStringExtensions", "HTTP", "JSON", "Markdown", "Reexport"]
git-tree-sha1 = "8ff3884b3f5613214b520d6054f8df8ce0de1396"
uuid = "b3565e16-c1f2-4fe9-b4ab-221c88942068"
version = "1.0.0"

[[deps.LRUCache]]
git-tree-sha1 = "5519b95a490ff5fe629c4a7aa3b3dfc9160498b3"
uuid = "8ac3fa9e-de4c-5943-b1dc-09c6b5f20637"
version = "1.6.2"
weakdeps = ["Serialization"]

    [deps.LRUCache.extensions]
    SerializationExt = ["Serialization"]

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.Latexify]]
deps = ["Format", "Ghostscript_jll", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "44f93c47f9cd6c7e431f2f2091fcba8f01cd7e8f"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.10"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"
    TectonicExt = "tectonic_jll"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"
    tectonic_jll = "d7dd28d6-a5e6-559c-9131-7eb760cdacc5"

[[deps.LazilyInitializedFields]]
git-tree-sha1 = "0f2da712350b020bc3957f269c9caad516383ee0"
uuid = "0e77f7df-68c5-4e49-93ce-4cd80f5598bf"
version = "1.3.0"

[[deps.LeftChildRightSiblingTrees]]
deps = ["AbstractTrees"]
git-tree-sha1 = "95ba48564903b43b2462318aa243ee79d81135ff"
uuid = "1d6d02ad-be62-4b6b-8a6d-2f90e265016e"
version = "0.2.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be484f5c92fad0bd8acfef35fe017900b0b73809"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.18.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "f02b56007b064fbfddb4c9cd60161b6dd0f40df3"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.1.0"

[[deps.LoweredCodeUtils]]
deps = ["CodeTracking", "Compiler", "JuliaInterpreter"]
git-tree-sha1 = "73b98709ad811a6f81d84e105f4f695c229385ba"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "3.4.3"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.Malt]]
deps = ["Distributed", "Logging", "RelocatableFolders", "Serialization", "Sockets"]
git-tree-sha1 = "636abf4fb184be05888dacc0b636fe0911d6d746"
uuid = "36869731-bdee-424d-aa32-cab38c994e3b"
version = "1.2.0"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MarkdownLiteral]]
deps = ["CommonMark", "HypertextLiteral"]
git-tree-sha1 = "f7d73634acd573bf3489df1ee0d270a5d6d3a7a3"
uuid = "736d6165-7244-6769-4267-6b50796e6954"
version = "0.1.2"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Memoize]]
deps = ["MacroTools"]
git-tree-sha1 = "2b1dfcba103de714d31c033b5dacc2e4a12c7caa"
uuid = "c03570c3-d221-55d1-a50c-7939bbd78826"
version = "0.4.4"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.MsgPack]]
deps = ["Serialization"]
git-tree-sha1 = "f5db02ae992c260e4826fe78c942954b48e1d9c2"
uuid = "99f44e22-a591-53d1-9472-aa23ef4bd671"
version = "1.2.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OpenSSH_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "OpenSSL_jll", "Zlib_jll"]
git-tree-sha1 = "cb7acd5d10aff809b4d0191dfe1956c2edf35800"
uuid = "9bd350c2-7e96-507f-8002-3f2e150b4e1b"
version = "10.0.1+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "f1a7e086c677df53e064e0fdd2c9d0b0833e3f6e"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.5.0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "2ae7d4ddec2e13ad3bddf5c0796f7547cf682391"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "05868e21324cede2207c6f0f466b4bfef6d5e7ee"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "7d2f8f21da5db6a806faf7b9b292296da42b2810"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.Pluto]]
deps = ["Base64", "Configurations", "Dates", "Downloads", "ExpressionExplorer", "FileWatching", "GracefulPkg", "HTTP", "HypertextLiteral", "InteractiveUtils", "LRUCache", "Logging", "LoggingExtras", "MIMEs", "Malt", "Markdown", "MsgPack", "Pkg", "PlutoDependencyExplorer", "PrecompileSignatures", "PrecompileTools", "REPL", "RegistryInstances", "RelocatableFolders", "Scratch", "Sockets", "TOML", "Tables", "URIs", "UUIDs"]
git-tree-sha1 = "7cddd8a094d2eedf43f21be40d9090f4a5217255"
uuid = "c3e4b0f8-55cb-11ea-2926-15256bba5781"
version = "0.20.17"

[[deps.PlutoDependencyExplorer]]
deps = ["ExpressionExplorer", "InteractiveUtils", "Markdown"]
git-tree-sha1 = "c3e5073a977b1c58b2d55c1ec187c3737e64e6af"
uuid = "72656b73-756c-7461-726b-72656b6b696b"
version = "1.2.2"

[[deps.PlutoHooks]]
deps = ["InteractiveUtils", "Markdown", "UUIDs"]
git-tree-sha1 = "072cdf20c9b0507fdd977d7d246d90030609674b"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0774"
version = "0.0.5"

[[deps.PlutoLinks]]
deps = ["FileWatching", "InteractiveUtils", "Markdown", "PlutoHooks", "Revise", "UUIDs"]
git-tree-sha1 = "8f5fa7056e6dcfb23ac5211de38e6c03f6367794"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0420"
version = "0.1.6"

[[deps.PlutoSliderServer]]
deps = ["AbstractPlutoDingetjes", "Base64", "BetterFileWatching", "Configurations", "Distributed", "FromFile", "Git", "Glob", "GracefulPkg", "HTTP", "JSON", "Logging", "Pkg", "Pluto", "PlutoDependencyExplorer", "SHA", "Serialization", "Sockets", "TOML", "TerminalLoggers", "UUIDs"]
git-tree-sha1 = "e4bb5fbc2a56a9aedabd002e37546473d7358a4f"
uuid = "2fc8631c-6f24-4c5b-bca7-cbb509c42db4"
version = "1.5.0"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "Latexify", "Markdown", "PlutoUI"]
git-tree-sha1 = "85778cdf2bed372008e6646c64340460764a5b85"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.4.5"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "8329a3a4f75e178c11c1ce2342778bcbbbfa7e3c"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.71"

[[deps.PrecompileSignatures]]
git-tree-sha1 = "18ef344185f25ee9d51d80e179f8dad33dc48eb1"
uuid = "91cefc8d-f054-46dc-8f8c-26e11d7c5411"
version = "3.0.3"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "0f27480397253da18fe2c12a4ba4eb9eb208bf3d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.ProgressLogging]]
deps = ["Logging", "SHA", "UUIDs"]
git-tree-sha1 = "d95ed0324b0799843ac6f7a6a85e65fe4e5173f0"
uuid = "33c8b6b6-d38a-422a-b730-caa89a2f386c"
version = "0.1.5"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RegistryInstances]]
deps = ["LazilyInitializedFields", "Pkg", "TOML", "Tar"]
git-tree-sha1 = "ffd19052caf598b8653b99404058fce14828be51"
uuid = "2792f1a3-b283-48e8-9a74-f99dce5104f3"
version = "0.1.0"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.Revise]]
deps = ["CodeTracking", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "d852eba0cc08181083a58d5eb9dccaec3129cb03"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.9.0"
weakdeps = ["Distributed"]

    [deps.Revise.extensions]
    DistributedExt = "Distributed"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "9b81b8393e50b7d4e6d0a9f14e192294d3b7c109"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.3.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.ShortCodes]]
deps = ["Base64", "CodecZlib", "Downloads", "JSON3", "Memoize", "URIs", "UUIDs"]
git-tree-sha1 = "5844ee60d9fd30a891d48bab77ac9e16791a0a57"
uuid = "f62ebe17-55c5-4640-972f-b59c0dd11ccf"
version = "0.3.6"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "f305871d2f381d21527c770d4788c06c097c9bc1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.2.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StructTypes]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "159331b30e94d7b11379037feeb9b690950cace8"
uuid = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"
version = "1.11.0"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "f2c1efbc8f3a609aadf318094f8fc5204bdaf344"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.12.1"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TerminalLoggers]]
deps = ["LeftChildRightSiblingTrees", "Logging", "Markdown", "Printf", "ProgressLogging", "UUIDs"]
git-tree-sha1 = "f133fab380933d042f6796eda4e130272ba520ca"
uuid = "5d786b92-1e48-4d6f-9151-6b4477ca9bed"
version = "0.1.7"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[deps.Tricks]]
git-tree-sha1 = "372b90fe551c019541fafc6ff034199dc19c8436"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.12"

[[deps.URIs]]
git-tree-sha1 = "bef26fb046d031353ef97a82e3fdb6afe7f21b1a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.6.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─6a3d0a57-5934-47d8-9015-fa0eb465582f
# ╟─b0dcbe50-9e2f-4650-b5d1-9bdbaa9c1c9e
# ╟─aee5f220-89d9-11f0-24d1-9fe74cca62d3
# ╟─4dfd1f12-f334-443b-a6c3-87cf1e49d15b
# ╟─c677ae2c-04f4-4009-8f77-4a5537d52d32
# ╟─e174ee27-7f3e-4cda-993a-7f3e92e0c325
# ╟─aeaa2125-2718-41a7-981e-3740224b817c
# ╟─54afd7f3-00eb-4154-b88b-53c801abb100
# ╟─3688e433-9ee4-4592-99ce-8f94b29a0ab0
# ╟─09a4f87f-bddb-4db0-a943-829cda17d4d0
# ╟─7c759c32-1b47-4f3f-97c1-d638d52ee2af
# ╟─3b3998ad-9f1d-4ef7-a760-4d7edd6d5782
# ╟─976e7588-6e3e-4617-a9ff-4100373b1aa4
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
