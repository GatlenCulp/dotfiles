({
  katexConfig: {
    "macros": {
      "\\E": "\\mathbb{E}",
      "\\P": "\\mathbb{P}",
    }
  },
  
  mathjaxConfig: {
    tex: {
      macros: {
        // Definitions
        colonequals: "{\\mathrel{\\vcenter{:}}=}",
        trieq: "{\\mathrel{\\vcenter{:}}=}",
        defeq: "{\\mathrel{\\vcenter{:}}=}",
        // Wrappers
        set: ["{\\left\\{#1\\right\\}}", 1],
        norm: ["{\\left\\lVert#1\\right\\rVert}", 1],
        trace: "{\\mathrm{Tr}}",
        textsc: ["{\\text{\\scshape #1}}", 1],

        
        bm: ["{\\boldsymbol{#1}}", 1],
        Reals: "{\\mathbb{R}}",
        el: "{\\mathcal{L}}",
        inn: "{\\in\\mathbb{N}}",
        out: "{\\in\\mathbb{R}}",
        
        // Vectors
        vzero: "{\\bm{0}}",
        vone: "{\\bm{1}}",
        vmu: "{\\bm{\\mu}}",
        vtheta: "{\\bm{\\theta}}",
        va: "{\\mathbf{a}}",
        vb: "{\\mathbf{b}}",
        vc: "{\\mathbf{c}}",
        vd: "{\\mathbf{d}}",
        ve: "{\\mathbf{e}}",
        vf: "{\\mathbf{f}}",
        vg: "{\\mathbf{g}}",
        vh: "{\\mathbf{h}}",
        vi: "{\\mathbf{i}}",
        vj: "{\\mathbf{j}}",
        vk: "{\\mathbf{k}}",
        vl: "{\\mathbf{l}}",
        vm: "{\\mathbf{m}}",
        vn: "{\\mathbf{n}}",
        vo: "{\\mathbf{o}}",
        vp: "{\\mathbf{p}}",
        vq: "{\\mathbf{q}}",
        vr: "{\\mathbf{r}}",
        vs: "{\\mathbf{s}}",
        vt: "{\\mathbf{t}}",
        vu: "{\\mathbf{u}}",
        vv: "{\\mathbf{v}}",
        vw: "{\\mathbf{w}}",
        vx: "{\\mathbf{x}}",
        vy: "{\\mathbf{y}}",
        vz: "{\\mathbf{z}}",

        // Matrix or Tensor
        mA: "{\\mathbf{A}}",
        mB: "{\\mathbf{B}}",
        mC: "{\\mathbf{C}}",
        mD: "{\\mathbf{D}}",
        mE: "{\\mathbf{E}}",
        mF: "{\\mathbf{F}}",
        mG: "{\\mathbf{G}}",
        mH: "{\\mathbf{H}}",
        mI: "{\\mathbf{I}}",
        mJ: "{\\mathbf{J}}",
        mK: "{\\mathbf{K}}",
        mL: "{\\mathbf{L}}",
        mM: "{\\mathbf{M}}",
        mN: "{\\mathbf{N}}",
        mO: "{\\mathbf{O}}",
        mP: "{\\mathbf{P}}",
        mQ: "{\\mathbf{Q}}",
        mR: "{\\mathbf{R}}",
        mS: "{\\mathbf{S}}",
        mT: "{\\mathbf{T}}",
        mU: "{\\mathbf{U}}",
        mV: "{\\mathbf{V}}",
        mW: "{\\mathbf{W}}",
        mX: "{\\mathbf{X}}",
        mY: "{\\mathbf{Y}}",
        mZ: "{\\mathbf{Z}}",
        mBeta: "{\\bm{\\beta}}",
        mPhi: "{\\bm{\\Phi}}",
        mLambda: "{\\bm{\\Lambda}}",
        mSigma: "{\\bm{\\Sigma}}",

        // Other definitions
        E: "{\\mathbb{E}}",
        Ls: "{\\mathcal{L}}",
        R: "{\\mathbb{R}}",
        softmax: "{\\mathrm{softmax}}",
        sigmoid: "{\\sigma}",
        relu: "{\\mathrm{ReLU}}",
        KL: "{D_{\\mathrm{KL}}}",
        Var: "{\\mathrm{Var}}",
        standarderror: "{\\mathrm{SE}}",
        Cov: "{\\mathrm{Cov}}",
        argmax: ["{\\mathop{\\mathrm{arg\\,max}}}", 0],
        argmin: ["{\\mathop{\\mathrm{arg\\,min}}}", 0],
        sign: ["{\\mathop{\\mathrm{sign}}}", 0],
        Tr: ["{\\mathop{\\mathrm{Tr}}}", 0],
        ab: "{\\allowbreak}"
      }
    },
    options: {},
    loader: {}
  },
  
  mermaidConfig: {
    "startOnLoad": false
  },
})