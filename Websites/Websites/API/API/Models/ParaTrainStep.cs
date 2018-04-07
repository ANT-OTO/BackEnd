using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API.Models
{
    public class ParaTrainStep
    {
        public int TrainStepId { get; set; }

        public string Title { get; set; }

        public string HTMLText { get; set; }

        public string VideoURL { get; set; }

        public bool IsComplete { get; set; }
    }
}